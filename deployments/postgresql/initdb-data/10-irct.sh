#!/usr/bin/env bash
set -e

IRCT_DB_PASSWORD="pFjy3EjDVwLfT2rB9xkK"

# create database & role
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE irct;
    CREATE ROLE irct LOGIN PASSWORD '$IRCT_DB_PASSWORD';

    grant all on schema public to irct;
    grant all privileges on all tables in schema public to irct;
EOSQL

# load structure & i2b2 resource data
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d irct -f "$INIT_DB_FOLDER/irct/irct_db_structure_dump_1.4.sql"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d irct -f "$INIT_DB_FOLDER/irct/irct_resource_i2b2_local.sql"
