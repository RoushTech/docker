# syntax = devthefuture/dockerfile-x
FROM ./PHP.Dockerfile#php-81-base AS php-81-node-base

ARG NODE_PACKAGES="npm nodejs yarn"
ENV NPM_CACHE_DIR=/var/cache/.npm \
    YARN_CACHE_FOLDER=/var/cache/.yarn \
    NPM_CONFIG_LOGLEVEL=warn \
    NPM_CONFIG_PREFIX=/var/cache/.npm/.npm-global \
    NPM_CONFIG_CACHE=/var/cache/.npm/.npm-cache \
    NPM_CONFIG_USERCONFIG=/var/cache/.npm/.npmrc \
    NODE_PATH=/var/cache/.npm/.npm-global/lib/node_modules:/usr/local/lib/node_modules:/usr/lib/node_modules \
    PATH="$NPM_CONFIG_PREFIX/bin:$PATH" \
    NO_UPDATE_NOTIFIER=true \
    NPM_WATCH_PATHS=""
USER root

# Copy in bits of node's fs and fix perms
COPY ./fs/node/. /
RUN sv-fix-perms

# Creating a volume for npm cache stuff to improve build performance.
VOLUME $NPM_CACHE_DIR
VOLUME $YARN_CACHE_FOLDER

# Install packages
RUN <<NODE_INSTALL_PACKAGES
  mkdir -p $NPM_CACHE_DIR $YARN_CACHE_FOLDER

  apk add -U --no-cache $NODE_PACKAGES

  chown app:app -Rv $NPM_CACHE_DIR $YARN_CACHE_FOLDER
  chmod a+w /var/cache $NPM_CACHE_DIR $YARN_CACHE_FOLDER
NODE_INSTALL_PACKAGES

USER app
RUN <<NODE_VERIFY
  npm --global cache verify

  # Verify the executables are present and accounted for. If they're missing, this'll throw an error.
  echo "NPM Version: "
  npm --version
  echo "Yarn Version: "
  yarn --version
  echo "Node Version: "
  node --version

  # if files are found in /var/cache/.npm that are not owned by the current user, exit with an error
  find $NPM_CACHE_DIR -not -user $SYSTEM_USER | wc -l | grep -q 0 || exit 1
NODE_VERIFY

USER root