#!/usr/bin/env bash
set -e

TRANSMART_DIR="/tmp/transmart-repo"
TRANSMART_VERSION="tags/v17.1-rc.9"

# get the transmart repo
git init "$TRANSMART_DIR"
pushd "$TRANSMART_DIR"
git remote add origin https://github.com/thehyve/transmart-core.git
git config core.sparsecheckout true
echo "transmart-data/*" >> .git/info/sparse-checkout
git pull --depth=1 origin "$TRANSMART_VERSION"
chmod -R 777 .
popd

# run the transmart data loading scripts
pushd "$TRANSMART_DIR"/transmart-data
cat > vars <<EOL
PGHOST=localhost
PGPORT=5432
PGDATABASE=transmart_17_1
PGUSER=postgres
PGPASSWORD=$POSTGRES_PASSWORD
TABLESPACES=/var/lib/postgresql/tablespaces/
PGSQL_BIN=/usr/lib/postgresql/9.6/bin/
export PGHOST PGPORT PGDATABASE PGUSER PGPASSWORD TABLESPACES PGSQL_BIN
EOL
. ./vars
make postgres_drop
skip_fix_tablespaces=1 make postgres_test #-j4 removed
popd
