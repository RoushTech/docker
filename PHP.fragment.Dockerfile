ENV PHP_VERSION=$PHP_VERSION \
    NGINX_VERSION=$NGINX_VERSION \
    COMPOSER_VERSION=$COMPOSER_VERSION \
    COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME=/var/cache/.composer \
    COMPOSER_FUND=0 \
    PATH="/app/vendor/bin:${PATH}" \
    PHP_MEMORY_LIMIT=256M \
    PHP_CLI_MEMORY_LIMIT=4096M \
    PHP_ERROR_REPORTING=E_ALL \
    PHP_DISPLAY_ERRORS=1 \
    LOG_PATHS="/var/log/nginx_access.log /var/log/nginx_error.log /var/log/php_access.log /var/log/php_error.log $LOG_PATHS"

LABEL net.roushtech.version.php=${PHP_VERSION} \
      net.roushtech.version.nginx=${NGINX_VERSION} \
      net.roushtech.version.composer=${COMPOSER_VERSION}

# hadolint ignore=DL3018
RUN <<INSTALL_PHP_AND_FRIENDS
  # Install PHP+Friends
  apk add --no-cache $PHP_PACKAGES $EXTRA_PACKAGES

  # remove nginx, postgres and redis  user if they exist, we didn't ask to create them but install scripts do it anyway
  deluser nginx || true
  deluser postgres || true
  deluser redis || true
INSTALL_PHP_AND_FRIENDS

RUN <<INSTALL_COMPOSER
  # Install composer
  curl https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar --output /usr/local/bin/composer --silent
  chmod +x /usr/local/bin/composer
INSTALL_COMPOSER

# Remove the default php config files
RUN rm /etc/php /etc/php* -Rf || true
COPY ./fs/php-nginx/. /

# Fix perms
RUN <<FIX_PERMS
  set -ue
  PHP_VER=$(echo $PHP_VERSION | tr -d '.')
  # if PHP_VER is less than 80, set it to 7
  if [[ "$PHP_VER" -lt 80 ]]; then
    PHP_VER=7
  fi

  # Move some binary names around as well as other bits and pieces
  mkdir /run/php-fpm
  ln -s /etc/php /etc/php${PHP_VER} || true
  ln -s /usr/bin/php${PHP_VER} /usr/bin/php || true
  ln -s /usr/sbin/php-fpm${PHP_VER} /usr/sbin/php-fpm
  ln -s /usr/share/php${PHP_VER} /usr/share/php
  ln -s /var/log/php${PHP_VER} /var/log/php

  # if we're PHP 7, we need to comment out pm.max_spawn_rate in /etc/php/php-fpm.d/www.conf
  if [[ "$PHP_VER" -eq 7 ]]; then
    sed -i 's/^pm.max_spawn_rate = .*/;pm.max_spawn_rate = 20/' /etc/php/php-fpm.d/www.conf
  fi

  # Fix paths
  mkdir -p /var/log/nginx

  # Fix execution and ownership
  /usr/local/bin/sv-fix-perms
  rm -Rf \
    /var/log/php/ /var/log/php*/ \
    /var/log/redis \
     || true
  touch /var/log/php_error.log /var/log/php_access.log
  chown app:app -R \
    /app \
    /var/lib/nginx /var/log/nginx /run/nginx \
    /var/log/php* /run/php-fpm /usr/share/php*

  # json got merged into PHP in 8.0, so we remove the old json config files
  if [[ "$PHP_VER" -ge 80 ]]; then
    rm /etc/php/conf.d/*_json.ini || true
  fi
FIX_PERMS

# Switch to the app user
USER app

# Configure SSH to trust github.com
RUN <<TRUST_GITHUB
  set -ue
  mkdir -p ~/.ssh
  ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
TRUST_GITHUB

# Add a generic healthcheck
HEALTHCHECK --interval=5s --start-period=10s \
  CMD /usr/local/bin/healthcheck

USER root
SHELL ["/bin/bash", "-ce"]
#RUN /usr/local/bin/validate
