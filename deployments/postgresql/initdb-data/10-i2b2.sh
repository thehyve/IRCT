#!/usr/bin/env bash
set -e

I2B2_DATA_DIR="/tmp/i2b2-data"
I2B2_VERSION="b1.7.10.003-QA"

# get the i2b2 data
git init "$I2B2_DATA_DIR"
pushd "$I2B2_DATA_DIR"
git remote add origin https://github.com/i2b2/i2b2-data.git
git pull --depth=1 origin tags/$I2B2_VERSION
git apply "$INIT_DB_FOLDER/i2b2/patches/"*.diff
chmod -R 777 .
popd

# set up env variables for i2b2 data loading scripts
export  I2B2_DOMAIN_NAME="i2b2demo" \
        I2B2_DB_PASSWORD="pFjy3EjDVwLfT2rB9xkK" \
        I2B2_DEMO_DB_NAME="i2b2" \
        I2B2_FR_FILES_DIR="/opt/jboss/wildfly/standalone/data/i2b2_FR_files" \
        I2B2_DATA_DIR

# run the i2b2 data loading scripts
pushd "$INIT_DB_FOLDER/i2b2"
for f in ./*.sh; do
    bash "$f"
done
popd
