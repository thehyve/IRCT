#!/usr/bin/env bash
set -e
# download, compile, install and deploy IRCT
# this script also supports updates, simply run it again

# enable maven 3.5
source /opt/rh/rh-maven35/enable

# cleanup & prevent deployment in wildfly while building
if [ -f "$IRCT_WAR" ]; then
    rm "$IRCT_WAR"*
fi
touch "$IRCT_WAR.skipdeploy"

# compile & deploy IRCT
pushd "$IRCT_SRC_DIR"
mvn install
cp IRCT-CL/target/IRCT-CL.war "$IRCT_WAR"
popd

# configure and deploy in wildfly
pushd "$JBOSS_WAR_DEPLOYMENTS"
mv "$IRCT_WAR.skipdeploy" "$IRCT_WAR.dodeploy"
popd
