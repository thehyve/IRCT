#!/usr/bin/env bash
set -Eeuo pipefail

# wait for postgres to be available
export PGPASSWORD="$I2B2_DB_PW"
export PSQL_PARAMS="-v ON_ERROR_STOP=1 -h ${I2B2_DB_HOST} -p ${I2B2_DB_PORT} -U ${I2B2_DB_USER}"
until psql $PSQL_PARAMS -d postgres -c '\q'; do
  >&2 echo "Waiting for postgresql..."
  sleep 1
done

# load initial data if database does not exist (credentials must be valid and have create database right)
DB_CHECK=`psql $PSQL_PARAMS -d postgres -X -A -t -c "select count(*) from pg_database where datname = '${I2B2_DB_NAME}';"`
if [ "$DB_CHECK" -ne "1" ]; then
echo "Initialising i2b2 database"
    psql $PSQL_PARAMS -d postgres <<-EOSQL
        CREATE DATABASE ${I2B2_DB_NAME};
EOSQL

    # get the i2b2 data
    git init "$I2B2_DATA_DIR"
    pushd "$I2B2_DATA_DIR"
    git remote add origin https://github.com/i2b2/i2b2-data.git
    git pull --depth=1 origin $I2B2_DATA_VERSION
    popd

    # run loading scripts
    for f in "$I2B2_SQL_DIR"/*.sh; do
        bash "$f"
    done
fi

# write data sources & set admin password & run wildfly
write-i2b2-datasources.sh
$JBOSS_HOME/bin/add-user.sh admin $WILDFLY_ADMIN_PASSWORD --silent || true
exec /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
