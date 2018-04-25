#!/usr/bin/env bash
set -e

TRANSMART171_SRC_DIR="/tmp/transmart-17.1-src"
TRANSMART171_VERSION="tags/v17.1-rc.9"
TRANSMART171_VERSION_WAR_FILE="17.1-RC9"
#POSTGRES_PASSWORD="postgres"
#TSUSER_HOME="$JBOSS_HOME/standalone/configuration"
#TRANSMART_CONFIG_FOLDER="$TSUSER_HOME/.grails/transmartConfig"

# prevent deployment in wildfly while building
pushd "$JBOSS_WAR_DEPLOYMENTS"
touch "transmart-17.1.war.skipdeploy"
popd

# get the transmart repo & write config & compile it
git init "$TRANSMART171_SRC_DIR"
pushd "$TRANSMART171_SRC_DIR"
git remote add origin https://github.com/thehyve/transmart-core.git
git pull --depth=1 origin "$TRANSMART171_VERSION"

#export TSUSER_HOME
#mkdir -p "$TRANSMART_CONFIG_FOLDER"
#cp "$BUILD_SCRIPTS_FOLDER"/transmart-17.1/application.groovy \
#    "$TRANSMART_CONFIG_FOLDER"/application.groovy

gradle :transmart-server:bootRepackage
cp transmart-server/build/libs/transmart-server-17.1-$TRANSMART171_VERSION_WAR_FILE.war \
    "$JBOSS_WAR_DEPLOYMENTS"/transmart-17.1.war
popd

# configure and deploy in wildfly
"$JBOSS_HOME"/bin/jboss-cli.sh --connect --file="$BUILD_SCRIPTS_FOLDER"/transmart-17.1/wildfly-config.cli
pushd "$JBOSS_WAR_DEPLOYMENTS"
mv "transmart-17.1.war.skipdeploy" "transmart-17.1.war.dodeploy"
popd
