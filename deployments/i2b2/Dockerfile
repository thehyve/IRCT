FROM jboss/wildfly:10.0.0.Final

# run-time variables
ENV I2B2_DB_HOST="postgresql-server" \
    I2B2_DB_PORT="5432" \
    I2B2_DB_USER="i2b2" \
    I2B2_DB_PW="i2b2" \
    I2B2_DB_NAME="i2b2"
ENV WILDFLY_ADMIN_PASSWORD="admin" \
    I2B2_DOMAIN_NAME="i2b2demo"

# build-time variables
ENV JBOSS_WAR_DEPLOYMENTS="$JBOSS_HOME/standalone/deployments" \
    AXIS2_VERSION="1.7.1" \
    AXIS2_LOGLEVEL="INFO" \
    I2B2_SRC_DIR="/i2b2-src" \
    I2B2_SQL_DIR="/i2b2-sql" \
    I2B2_DATA_DIR="/i2b2-data" \
    I2B2_PATCHES_DIR="/i2b2-patches" \
    I2B2_VERSION="tags/v1.7.10.0001" \
    I2B2_DATA_VERSION="tags/v1.7.10.0002" \
    I2B2_FR_FILES_DIR="$JBOSS_HOME/standalone/data/i2b2_FR_files" \
    PG_JDBC_JAR="postgresql-42.1.4.jar" \
    I2B2_SERVICE_PASSWORD="pFjy3EjDVwLfT2rB9xkK"
# todo: I2B2_SERVICE_PASSWORD is hard-coded in 10-i2b2-pm-configuration.sh

# pre-requisites: packages & wildfly config
USER root
RUN sed -i 's/Xmx512m/Xmx2048m/g' $JBOSS_HOME/bin/standalone.conf && \
    sed -i 's/MaxMetaspaceSize=256m/MaxMetaspaceSize=1024m/g' $JBOSS_HOME/bin/standalone.conf && \
    yum update -y && \
    yum -y install wget git ant postgresql && \
    yum clean all
COPY install-i2b2.sh docker-entrypoint.sh write-i2b2-datasources.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install-i2b2.sh /usr/local/bin/docker-entrypoint.sh /usr/local/bin/write-i2b2-datasources.sh
COPY sql "$I2B2_SQL_DIR"
COPY patches "$I2B2_PATCHES_DIR"
RUN mkdir -p "$I2B2_SRC_DIR" "$I2B2_DATA_DIR" && \
    chown -R jboss:jboss "$I2B2_SRC_DIR" "$I2B2_DATA_DIR"
USER jboss

# install i2b2
RUN install-i2b2.sh

# run
EXPOSE 8080 9990
ENTRYPOINT docker-entrypoint.sh
