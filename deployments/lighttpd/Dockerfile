FROM debian:jessie-backports

# variables
ENV LIGHTTPD_WEB_ROOT="/var/www/html"

# pre-requisites
RUN echo "deb http://httpredir.debian.org/debian jessie-backports main contrib non-free" >> /etc/apt/sources.list && \
    apt-get -y update && \
    apt-get -y install lighttpd php5-cgi curl libcurl3 php5-common php5-cli php5-curl git php5-pgsql wget tar && \
    apt-get -y -t jessie-backports install postgresql-client && \
    apt-get -y clean && \
    lighttpd-enable-mod fastcgi-php && \
    chgrp -R www-data /etc/lighttpd && \
    chmod -R g+rwx /etc/lighttpd && \
    chown -R www-data:www-data "$LIGHTTPD_WEB_ROOT" && \
    chmod -R +rx "$LIGHTTPD_WEB_ROOT" && \
    install -d -o www-data -g www-data -m 0750 "/var/run/lighttpd"
USER www-data
WORKDIR "$LIGHTTPD_WEB_ROOT"

# install phpPgAdmin
ARG POSTGRESQL_HOST_ARG="postgresql"
ENV POSTGRESQL_HOST="$POSTGRESQL_HOST_ARG"
RUN wget http://downloads.sourceforge.net/phppgadmin/phpPgAdmin-5.1.tar.gz?download && \
    tar xvzf phpPgAdmin-5.1.tar.gz?download && \
    rm phpPgAdmin-5.1.tar.gz\?download && \
    mv phpPgAdmin-5.1 phppgadmin && \
    sed -i "s/'host'] = ''/'host'] = '$POSTGRESQL_HOST'/" phppgadmin/conf/config.inc.php && \
    sed -i "s/ = 'PostgreSQL'/ = 'PostgreSQL Server'/" phppgadmin/conf/config.inc.php && \
    sed -i "s/'extra_login_security'] = true/'extra_login_security'] = false/" phppgadmin/conf/config.inc.php && \
    sed -i "/\$cmd = \$exe/c\$cmd = \$exe;" phppgadmin/dbexport.php

# install i2b2 webclient & admin tool
ENV I2B2_WEB_DIR="$LIGHTTPD_WEB_ROOT/i2b2-webclient-repo" \
    I2B2_VERSION="tags/v1.7.10.0001" \
    I2B2_DOMAIN_NAME="i2b2demo"
RUN mkdir "$I2B2_WEB_DIR" && \
    git clone https://github.com/i2b2/i2b2-webclient.git "$I2B2_WEB_DIR" && \
    git -C "$I2B2_WEB_DIR" checkout $I2B2_VERSION  && \
    cp -R "$I2B2_WEB_DIR" "$LIGHTTPD_WEB_ROOT/i2b2-admin" && \
    cp -R "$I2B2_WEB_DIR" "$LIGHTTPD_WEB_ROOT/i2b2-client"
COPY i2b2-web-writeconfig.sh ./
RUN bash i2b2-web-writeconfig.sh

# run
USER root
EXPOSE 80
CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
