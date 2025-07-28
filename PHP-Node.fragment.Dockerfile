ARG NODE_PACKAGES="npm nodejs yarn"
ENV NODE_VERSION=$NODE_VERSION \
    YARN_VERSION=$YARN_VERSION \
    NPM_VERSION=$NPM_VERSION \
    NPM_CACHE_DIR=/var/cache/.npm \
    YARN_CACHE_FOLDER=/var/cache/.yarn \
    NPM_CONFIG_LOGLEVEL=warn \
    NPM_CONFIG_PREFIX=/var/cache/.npm/.npm-global \
    NPM_CONFIG_CACHE=/var/cache/.npm/.npm-cache \
    NPM_CONFIG_USERCONFIG=/var/cache/.npm/.npmrc \
    NODE_PATH=/var/cache/.npm/.npm-global/lib/node_modules:/usr/local/lib/node_modules:/usr/lib/node_modules \
    PATH="$NPM_CONFIG_PREFIX/bin:$PATH" \
    NO_UPDATE_NOTIFIER=true \
    NPM_WATCH_PATHS=""
LABEL net.roushtech.version.node=${NODE_VERSION} \
      net.roushtech.version.yarn=${YARN_VERSION} \
      net.roushtech.version.npm=${NPM_VERSION}
USER root

# Copy in bits of node's fs and fix perms
COPY ./fs/node/. /
RUN sv-fix-perms

# Install packages
RUN <<NODE_INSTALL_PACKAGES
  mkdir -p $NPM_CACHE_DIR $YARN_CACHE_FOLDER
  chown $SYSTEM_USER:$SYSTEM_USER $NPM_CACHE_DIR $YARN_CACHE_FOLDER
  apk add --no-cache $NODE_PACKAGES
  chmod a+w /var/cache $NPM_CACHE_DIR $YARN_CACHE_FOLDER
NODE_INSTALL_PACKAGES

USER app
RUN <<NODE_VERIFY
   npm --global cache verify
NODE_VERIFY

USER root
RUN /usr/local/bin/validate
