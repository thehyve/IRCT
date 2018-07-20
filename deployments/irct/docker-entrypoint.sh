#!/usr/bin/env bash
set -Eeuo pipefail

# install IRCT from latest sources
install-irct.sh

# wait for postgres to be available
export PGPASSWORD="$IRCT_DB_PW"
PSQL_PARAMS="-v ON_ERROR_STOP=1 -h ${IRCT_DB_HOST} -p ${IRCT_DB_PORT} -U ${IRCT_DB_USER}"
until psql $PSQL_PARAMS -d postgres -c '\q'; do
  >&2 echo "Waiting for postgresql..."
  sleep 1
done

# load initial data if database does not exist (credentials must be valid and have create database right)
DB_CHECK=`psql $PSQL_PARAMS -d postgres -X -A -t -c "select count(*) from pg_database where datname = '${IRCT_DB_NAME}';"`
if [ "$DB_CHECK" -ne "1" ]; then
echo "Initialising IRCT database"
    psql $PSQL_PARAMS -d postgres <<-EOSQL
        CREATE DATABASE ${IRCT_DB_NAME};
EOSQL

    psql $PSQL_PARAMS -d $IRCT_DB_NAME <<-EOSQL
        grant all on schema public to ${IRCT_DB_USER};
        grant all privileges on all tables in schema public to ${IRCT_DB_USER};
EOSQL

    psql $PSQL_PARAMS -d $IRCT_DB_NAME -f "$IRCT_SQL_DIR/db_structure_dump_1.4.sql"
    psql $PSQL_PARAMS -d $IRCT_DB_NAME -f "$IRCT_SQL_DIR/dataconverterimplementations.sql"
    psql $PSQL_PARAMS -d $IRCT_DB_NAME -f "$IRCT_SQL_DIR/i2b2_resource_function.sql"
    psql $PSQL_PARAMS -d $IRCT_DB_NAME -f "$IRCT_SQL_DIR/medco_resource_function.sql"

    # add i2b2 resource with default credentials
    psql $PSQL_PARAMS -d $IRCT_DB_NAME <<-EOSQL
        select add_i2b2_resource(
            'i2b2-local',
            'http://i2b2:8080/i2b2/services/',
            '',
            '',
            '',
            'i2b2demo',
            'demo',
            'demouser',
            'false',
            'false',
            'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2XMLResourceImplementation',
            'TREE'
        );
EOSQL

    # add i2b2 resource that uses JWT for authentication
    psql $PSQL_PARAMS -d $IRCT_DB_NAME <<-EOSQL
        select add_i2b2_resource(
            'i2b2-local-jwt',
            'http://i2b2:8080/i2b2/services/',
            '',
            '',
            '',
            'i2b2demo',
            '',
            '',
            'false',
            'true',
            'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2XMLResourceImplementation',
            'TREE'
        );
EOSQL

    # add i2b2 resource online public demo
    psql $PSQL_PARAMS -d $IRCT_DB_NAME <<-EOSQL
        select add_i2b2_resource(
            'i2b2-public',
            'http://services.i2b2.org/i2b2/services/',
            '',
            '',
            '',
            'i2b2demo',
            'demo',
            'demouser',
            'false',
            'false',
            'edu.harvard.hms.dbmi.bd2k.irct.ri.i2b2.I2B2XMLResourceImplementation',
            'TREE'
        );
EOSQL

    # add medco resource local using default credentials
    psql $PSQL_PARAMS -d $IRCT_DB_NAME <<-EOSQL
        select add_i2b2_medco_resource(
            'i2b2-medco-local',
            'http://i2b2-medco-srv0:8080/i2b2/services/,http://i2b2-medco-srv1:8080/i2b2/services/,http://i2b2-medco-srv2:8080/i2b2/services/',
            'i2b2medcosrv0,i2b2medcosrv1,i2b2medcosrv2',
            'demo',
            'demouser',
            'true',
            'false',
            'edu.harvard.hms.dbmi.bd2k.irct.ri.medco.I2B2MedCoResourceImplementation',
            'TREE'
        );
EOSQL

    # add medco resource local using default credentials
    psql $PSQL_PARAMS -d $IRCT_DB_NAME <<-EOSQL
        select add_i2b2_medco_resource(
            'i2b2-medco-local-jwt',
            'http://i2b2-medco-srv0:8080/i2b2/services/,http://i2b2-medco-srv1:8080/i2b2/services/,http://i2b2-medco-srv2:8080/i2b2/services/',
            'i2b2medcosrv0,i2b2medcosrv1,i2b2medcosrv2',
            '',
            '',
            'true',
            'true',
            'edu.harvard.hms.dbmi.bd2k.irct.ri.medco.I2B2MedCoResourceImplementation',
            'TREE'
        );
EOSQL
fi


# set admin password & run wildfly
$JBOSS_HOME/bin/add-user.sh admin $WILDFLY_ADMIN_PASSWORD --silent || true
exec /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
