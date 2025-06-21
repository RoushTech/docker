# syntax = devthefuture/dockerfile-x
#       ____  __  ______  ____  __ __
#      / __ \/ / / / __ \( __ )/ // /
#     / /_/ / /_/ / /_/ / __  / // /_
#    / ____/ __  / ____/ /_/ /__  __/
#   /_/   /_/ /_/_/    \____(_)/_/
FROM ./Alpine.Dockerfile#alpine-22-base AS php-84-base
ARG NGINX_VERSION=1.28
ARG PHP_VERSION=8.4
ARG COMPOSER_VERSION=latest-stable
ARG PHP_PACKAGES="php84 php84-bcmath php84-bz2 php84-calendar php84-ctype php84-curl php84-dom php84-exif php84-fileinfo php84-ftp \
                  php84-fpm php84-gd php84-gettext php84-gmp php84-iconv php84-imap php84-intl php84-ldap php84-mbstring \
                  php84-mysqli php84-mysqlnd php84-odbc php84-opcache php84-openssl php84-pcntl \
                  php84-pdo php84-pdo_dblib php84-pdo_mysql php84-pdo_odbc php84-pdo_pgsql php84-pdo_sqlite php84-pgsql php84-phar \
                  php84-posix php84-session php84-shmop php84-simplexml php84-snmp php84-soap php84-sockets php84-sodium php84-sqlite3 \
                  php84-sysvmsg php84-sysvsem php84-sysvshm php84-tidy php84-tokenizer php84-xml php84-xmlreader php84-xmlwriter \
                  php84-xsl php84-zip php84-zlib \
                  php84-pecl-apcu php84-pecl-redis php84-pecl-msgpack php84-pecl-xdebug"
ARG EXTRA_PACKAGES="nginx sqlite postgresql-client mysql-client mariadb-connector-c redis"
INCLUDE ./PHP.fragment.Dockerfile

#       ____  __  ______  ____   ___
#      / __ \/ / / / __ \( __ ) <  /
#     / /_/ / /_/ / /_/ / __  | / /
#    / ____/ __  / ____/ /_/ / / /
#   /_/   /_/ /_/_/    \____(_)_/
FROM ./Alpine.Dockerfile#alpine-18-base AS php-81-base
ARG NGINX_VERSION=1.24
ARG PHP_VERSION=8.1
ARG COMPOSER_VERSION=2.2.25
ARG PHP_PACKAGES="php81 php81-bcmath php81-bz2 php81-calendar php81-ctype php81-curl php81-dom php81-exif php81-fileinfo php81-ftp \
                  php81-fpm php81-gd php81-gettext php81-gmp php81-iconv php81-imap php81-intl php81-ldap php81-mbstring \
                  php81-mysqli php81-mysqlnd php81-odbc php81-opcache php81-openssl php81-pcntl \
                  php81-pdo php81-pdo_dblib php81-pdo_mysql php81-pdo_odbc php81-pdo_pgsql php81-pdo_sqlite php81-pgsql php81-phar \
                  php81-posix php81-session php81-shmop php81-simplexml php81-snmp php81-soap php81-sockets php81-sodium php81-sqlite3 \
                  php81-sysvmsg php81-sysvsem php81-sysvshm php81-tidy php81-tokenizer php81-xml php81-xmlreader php81-xmlwriter \
                  php81-xsl php81-zip php81-zlib \
                  php81-pecl-apcu php81-pecl-redis php81-pecl-msgpack php81-pecl-xdebug"
ARG EXTRA_PACKAGES="nginx sqlite postgresql-client mysql-client mariadb-connector-c redis"
INCLUDE ./PHP.fragment.Dockerfile


#       ____  __  ______  _____ __ __
#      / __ \/ / / / __ \/__  // // /
#     / /_/ / /_/ / /_/ /  / // // /_
#    / ____/ __  / ____/  / //__  __/
#   /_/   /_/ /_/_/      /_/(_)/_/
FROM ./Alpine.Dockerfile#alpine-15-base AS php-74-base
ARG NGINX_VERSION=1.20
ARG PHP_VERSION=7.4
ARG COMPOSER_VERSION=2.2.25
ARG PHP_PACKAGES="php7 php7-bcmath php7-bz2 php7-calendar php7-ctype php7-curl php7-dom php7-exif php7-fileinfo php7-ftp \
                  php7-fpm php7-gd php7-gettext php7-gmp php7-iconv php7-imap php7-intl php7-json php7-ldap php7-mbstring \
                  php7-mysqli php7-mysqlnd php7-odbc php7-opcache php7-openssl php7-pcntl \
                  php7-pdo php7-pdo_dblib php7-pdo_mysql php7-pdo_odbc php7-pdo_pgsql php7-pdo_sqlite php7-pgsql php7-phar \
                  php7-posix php7-session php7-shmop php7-simplexml php7-snmp php7-soap php7-sockets php7-sodium php7-sqlite3 \
                  php7-sysvmsg php7-sysvsem php7-sysvshm php7-tidy php7-tokenizer php7-xml php7-xmlreader php7-xmlwriter \
                  php7-xsl php7-zip php7-zlib \
                  php7-pecl-apcu php7-pecl-redis php7-pecl-msgpack php7-pecl-xdebug"
ARG EXTRA_PACKAGES="nginx sqlite postgresql-client mysql-client mariadb-connector-c redis"
INCLUDE ./PHP.fragment.Dockerfile

FROM php-84-base AS php-84-node-base
ARG NODE_VERSION=22
ARG YARN_VERSION=1.22
ARG NPM_VERSION=11
INCLUDE ./PHP-Node.fragment.Dockerfile

FROM php-81-base AS php-81-node-base
ARG NODE_VERSION=18
ARG YARN_VERSION=1.22
ARG NPM_VERSION=9
INCLUDE ./PHP-Node.fragment.Dockerfile

FROM php-74-base AS php-74-node-base
ARG NODE_VERSION=16
ARG YARN_VERSION=1.22
ARG NPM_VERSION=8
INCLUDE ./PHP-Node.fragment.Dockerfile