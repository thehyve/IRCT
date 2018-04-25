FROM jboss/wildfly:10.0.0.Final

# variables (JBOSS_HOME, WILDFLY_VERSION exists)
ENV ADMIN_PASSWORD="admin" \
    JBOSS_WAR_DEPLOYMENTS="$JBOSS_HOME/standalone/deployments" \
    BUILD_SCRIPTS_FOLDER="/war-build-scripts"

# pre-requisites: packages & wildfly config
USER root
RUN $JBOSS_HOME/bin/add-user.sh admin $ADMIN_PASSWORD --silent && \
    sed -i 's/Xmx512m/Xmx3072m/g' $JBOSS_HOME/bin/standalone.conf && \
    sed -i 's/MaxMetaspaceSize=256m/MaxMetaspaceSize=1024m/g' $JBOSS_HOME/bin/standalone.conf && \
    yum update -y && \
    yum -y install wget git ant centos-release-scl grails groovy && \
    yum -y install rh-maven35 && \
    yum clean all && \
    wget https://services.gradle.org/distributions/gradle-2.13-bin.zip -O /tmp/gradle-bin.zip && \
    mkdir /opt/gradle && \
    unzip -d /opt/gradle /tmp/gradle-bin.zip && \
    rm -f /tmp/gradle-bin.zip

COPY war-build-scripts "$BUILD_SCRIPTS_FOLDER"
RUN chown -R jboss:jboss "$BUILD_SCRIPTS_FOLDER" && \
    chmod +x "$BUILD_SCRIPTS_FOLDER"/bin/*
USER jboss

# build wars with bash build-war.sh <name> ; gradle
ENV PATH="/opt/gradle/gradle-2.13/bin:$BUILD_SCRIPTS_FOLDER/bin:${PATH}"

# run
VOLUME $JBOSS_WAR_DEPLOYMENTS $JBOSS_HOME/standalone/configuration /opt/jboss/.grails
EXPOSE 8080 9990
ENTRYPOINT exec /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
