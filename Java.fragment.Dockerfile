LABEL net.roushtech.version.java=${JAVA_VERSION}
ENV PATH="${JAVA_HOME}/bin:${PATH}" \
    JAVA_VERSION=${JAVA_VERSION} \
    JAVA_OPTS=""
COPY ./fs/java/. /
RUN <<INSTALL_JAVA
  sv-fix-perms
  # Install our packages
  apk add --no-cache $JAVA_PACKAGES

  /usr/local/bin/validate
INSTALL_JAVA
