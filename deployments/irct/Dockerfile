FROM jboss/wildfly:10.0.0.Final

# run-time variables
ENV IRCT_DB_HOST="postgresql-server" \
    IRCT_DB_PORT="5432" \
    IRCT_DB_USER="irct" \
    IRCT_DB_PW="irct" \
    IRCT_DB_NAME="irct"
ENV IRCT_OIDC_ADDR="keycloak" \
    IRCT_OIDC_REDIRECT="/IRCT-UI/token.html" \
    IRCT_OIDC_CLIENT_ID="irct" \
    IRCT_OIDC_CLIENT_SECRET="rCwDRtQM510Du5bYGCHfLClM8XMph95aJwNsCr6MAucIiSxGeN5pcni3QRJqlYcc" \
    IRCT_OIDC_USER_FIELD="preferred_username" \
    IRCT_KEY_TIMEOUT="720" \
    IRCT_WHITELIST_FILE="false" \
    IRCT_RESULT_DATA_FOLDER="/opt/jboss/irct-results" \
    IRCT_OIDC_JWKS_ADDR="http://keycloak:8080/auth/realms/master/protocol/openid-connect/certs" \
    IRCT_CLIENT_SECRET="nosecret" \
    IRCT_CORS_ALLOW_ORIGIN="http://localhost:4200"
ENV WILDFLY_ADMIN_PASSWORD="admin"

# build-time variables
ENV JBOSS_WAR_DEPLOYMENTS="$JBOSS_HOME/standalone/deployments" \
    IRCT_SRC_DIR="/irct-src" \
    IRCT_SQL_DIR="/irct-sql" \
    PG_JDBC_JAR="postgresql-9.4.1212.jar"
ENV IRCT_WAR="$JBOSS_WAR_DEPLOYMENTS/IRCT-CL.war"

# pre-requisites packages & wildfly config
USER root
RUN sed -i 's/Xmx512m/Xmx1024m/g' $JBOSS_HOME/bin/standalone.conf && \
    sed -i 's/MaxMetaspaceSize=256m/MaxMetaspaceSize=512m/g' $JBOSS_HOME/bin/standalone.conf && \
    yum update -y && \
    yum -y install wget git centos-release-scl postgresql && \
    yum -y install rh-maven35 && \
    yum clean all
COPY install-irct.sh docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install-irct.sh /usr/local/bin/docker-entrypoint.sh
COPY standalone.xml "$JBOSS_HOME/standalone/configuration/"
COPY sql "$IRCT_SQL_DIR"
USER jboss

# postgresql JDBC driver
RUN wget -O "$JBOSS_WAR_DEPLOYMENTS/$PG_JDBC_JAR" \
    "http://central.maven.org/maven2/org/postgresql/postgresql/9.4.1212/postgresql-9.4.1212.jar" && \
    touch "$JBOSS_WAR_DEPLOYMENTS/$PG_JDBC_JAR.dodeploy"

RUN mkdir -p /opt/jboss/.m2/repository && \
    mkdir -p "$IRCT_RESULT_DATA_FOLDER"
VOLUME  $IRCT_SRC_DIR \
        $JBOSS_HOME/.m2/repository

EXPOSE 8080 9990
ENTRYPOINT docker-entrypoint.sh
