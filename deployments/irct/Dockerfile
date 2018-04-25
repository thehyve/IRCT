FROM jboss/wildfly:10.0.0.Final
# dev docker
# todo: psql from here?
# todo: rework for image that is not dev
# todo: configuration not needed as volume?

# variables (JBOSS_HOME, WILDFLY_VERSION exists)
ENV ADMIN_PASSWORD="admin" \
    JBOSS_WAR_DEPLOYMENTS="$JBOSS_HOME/standalone/deployments" \
    IRCT_SRC_DIR="/irct-src"
ENV IRCT_WAR="$JBOSS_WAR_DEPLOYMENTS/IRCT-CL.war"

# pre-requisites: packages & wildfly config
USER root
RUN $JBOSS_HOME/bin/add-user.sh admin $ADMIN_PASSWORD --silent && \
    sed -i 's/Xmx512m/Xmx2048m/g' $JBOSS_HOME/bin/standalone.conf && \
    sed -i 's/MaxMetaspaceSize=256m/MaxMetaspaceSize=1024m/g' $JBOSS_HOME/bin/standalone.conf && \
    yum update -y && \
    yum -y install wget git centos-release-scl && \
    yum -y install rh-maven35 && \
    yum clean all
COPY install-irct.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install-irct.sh
USER jboss

RUN mkdir -p /opt/jboss/.m2/repository
VOLUME  $IRCT_SRC_DIR \
        $JBOSS_HOME/.m2/repository \
        $JBOSS_WAR_DEPLOYMENTS \
        $JBOSS_HOME/standalone/configuration

EXPOSE 8080 9990
ENTRYPOINT exec /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
