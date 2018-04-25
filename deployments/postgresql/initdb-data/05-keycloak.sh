#!/usr/bin/env bash
set -e

KEYCLOAK_DB_PASSWORD="keycloak"

# create database & role
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE keycloak;
    CREATE ROLE keycloak LOGIN PASSWORD '$KEYCLOAK_DB_PASSWORD';

    grant all on schema public to keycloak;
    grant all privileges on all tables in schema public to keycloak;
EOSQL
