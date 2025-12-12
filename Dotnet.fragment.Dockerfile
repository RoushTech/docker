ENV DOTNET_WATCH_DIR=/app

RUN <<INSTALL_DOTNET
  # Add community repo for dotnet packages
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

  # Install .NET SDK and runtime
  apk add --no-cache $DOTNET_PACKAGES $EXTRA_PACKAGES

  # Verify dotnet binary is installed
  dotnet --version
INSTALL_DOTNET

SHELL ["/bin/bash", "-ce"]

COPY ./fs/dotnet/. /

RUN <<CLEANUP
/usr/local/bin/sv-fix-perms
/usr/local/bin/validate
CLEANUP
