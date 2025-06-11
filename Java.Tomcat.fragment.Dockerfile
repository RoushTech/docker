ENV CATALINA_HOME=/opt/tomcat \
    CATALINA_BASE=/opt/tomcat \
    PATH="/opt/tomcat/bin:$PATH"
COPY ./fs/tomcat /
RUN <<CONFIGURE_TOMCAT
set -x
    # Fix ownership & execution of service scripts
    sv-fix-perms
    # Download and install Apache Tomcat
    TOMCAT_MAJOR_VERSION=$(echo "$TOMCAT_VERSION" | cut -f1 -d'.')
    # if TOMCAT_MAJOR_VERSION is >= 9, use the dlcdn.apache.org CDN, otherwise use archive.apache.org
    if [ "$TOMCAT_MAJOR_VERSION" -ge 9 ]; then
        CDN="https://dlcdn.apache.org/"
    else
        CDN="https://archive.apache.org/dist/"
    fi
    wget -qO /tmp/apache-tomcat.tar.gz ${CDN}tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz
    mkdir -p $CATALINA_HOME
    tar -xzf /tmp/apache-tomcat.tar.gz --strip-components=1 -C $CATALINA_HOME
    rm -f /tmp/apache-tomcat.tar.gz
    mkdir -p $CATALINA_HOME/conf/Catalina/localhost
    chown -R app:app $CATALINA_HOME
    chmod +x $CATALINA_HOME/bin/*.sh

    # Verify the installation
    catalina.sh version
CONFIGURE_TOMCAT