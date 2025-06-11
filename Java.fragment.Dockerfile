ENV PATH="${JAVA_HOME}/bin:${PATH}" \
    JAVA_OPTS=""

RUN <<INSTALL_JAVA
  # Install our packages
  apk add --no-cache $JAVA_PACKAGES

  # Verify the PATH we set is sane
  if [ ! -d "$JAVA_HOME" ]; then
    echo "Java installation failed, $JAVA_HOME does not exist"
    exit 1;
  fi

  # validate that java is installed and working
  java -version
INSTALL_JAVA