ENV NODEJS_WATCH_DIR=/app

RUN <<INSTALL_NODE_AND_FRIENDS
  # Install Node, npm, and yarn
  apk add --no-cache $NODE_PACKAGES $EXTRA_PACKAGES

  # Verify binaries are installed
  echo "Node version:"
  node --version
  echo "NPM version:"
  npm --version
  echo "Yarn version:"
  yarn --version
INSTALL_NODE_AND_FRIENDS

SHELL ["/bin/bash", "-ce"]

COPY ./fs/node/. /

RUN <<CLEANUP
/usr/local/bin/sv-fix-perms
/usr/local/bin/validate
CLEANUP
