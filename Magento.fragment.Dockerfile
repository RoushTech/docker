LABEL net.roushtech.version.magento=2

COPY ./fs/magento/. /
RUN <<MAGENTO_CONFIGURE
  chmod +x /usr/local/bin/*
  # Fix ownership & execution of service scripts
  sv-fix-perms
  # Stuff the magento var directory outside of the app directory
  rm -rf /app/var
  mkdir -p /var/magento
  ln -s /var/magento /app/var
  chown $SYSTEM_USER:$SYSTEM_USER -R /var/magento /app/var
MAGENTO_CONFIGURE

RUN <<FIX_ENVIRONMENT
  # Set root path to /app/pub since the default is /app/public
  sed -i 's|root .*|root /app/pub;|g' /etc/nginx/http.d/default.conf
  # Set the default memory limit to 256M
  sed -i 's|memory_limit = .*|memory_limit = 256M|g' /etc/php/php.ini
  # Run the validate script to ensure this container isn't built incorrectly
  /usr/local/bin/validate
FIX_ENVIRONMENT