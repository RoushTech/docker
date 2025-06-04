VOLUME /var/cache/.composer

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
  curl https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar --output /usr/local/bin/composer
  chmod +x /usr/local/bin/composer

  # Confirm version
  composer --version
INSTALL_COMPOSER

# Remove the default php config files
RUN rm /etc/php* -Rf || true
COPY ./fs/php-nginx/. /

# Fix perms
RUN <<FIX_PERMS
  chmod +x /usr/local/bin/*
  sv-fix-perms
  # Fix ownership & execution
  mkdir -p \
    /var/log/nginx \
    /run/php-fpm
  chown app:app -R \
    /app \
    /var/lib/nginx /var/log/nginx /run/nginx \
    /var/log/php* /run/php-fpm
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