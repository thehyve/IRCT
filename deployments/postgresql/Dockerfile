FROM postgres:9.6

# variables
ENV POSTGRES_PASSWORD="postgres" \
    INIT_DB_FOLDER="/docker-entrypoint-initdb.d"

# pre-requisites: packages & add home folder for postgres user
RUN echo "deb http://httpredir.debian.org/debian jessie-backports main contrib non-free" >> /etc/apt/sources.list && \
    apt-get -y update && \
    apt-get -y install git ant default-jdk wget build-essential php5 curl && \
    apt-get -y -t jessie-backports install groovy2 && \
    apt-get -y clean && \
    mkdir -p /home/postgres && \
    chown postgres:postgres /home/postgres && \
    usermod -d /home/postgres postgres

# .sh, .sql and .sql.gz will automatically be executed in this directory
COPY initdb-data "$INIT_DB_FOLDER"
