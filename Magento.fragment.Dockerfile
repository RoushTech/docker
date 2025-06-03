USER root

LABEL org.opencontainers.image.source https://github.com/RoushTech/docker \
      org.opencontainers.image.description "Magento Runner" \
      org.opencontainers.image.vendor "RoushTech"
MAINTAINER "RoushTech <support@roushtech.net>"

COPY ./fs/magento/. /
RUN <<MAGENTO_CONFIGURE
  chmod +x /usr/local/bin/*
  # Fix ownership & execution of service scripts
  sv-fix-perms
  # Stuff the magento var directory outside of the app directory
  rm -rf /app/var
  mkdir -p /var/magento
  ln -s /var/magento /app/var
  chown app:app -R /var/magento /app/var
MAGENTO_CONFIGURE

RUN <<FIX_ENVIRONMENT
  # Set root path to /app/pub since the default is /app/public
  sed -i 's|root .*|root /app/pub;|g' /etc/nginx/http.d/default.conf
  sed -i 's|memory_limit = .*|memory_limit = 256M|g' /etc/php/php.ini
FIX_ENVIRONMENT

USER root