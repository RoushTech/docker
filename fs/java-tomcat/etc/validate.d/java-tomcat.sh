#!/bin/bash
source /usr/local/share/common.sh

# Verify Catalina is in path
which catalina.sh

# Verify Catalina is executable. Grep get everything after "Apache Tomcat/"
DETECTED_TOMCAT_VERSION=$(catalina.sh version 2>/dev/null | head -n 1 | grep -Eo 'Apache Tomcat/.*' | cut -d'/' -f2)

echo -e "Tomcat version\n detected: ${COLOR_GREY}${DETECTED_TOMCAT_VERSION}${COLOR_RESET}\n expected: ${COLOR_GREY}${TOMCAT_VERSION}${COLOR_RESET}"
if [ "${DETECTED_TOMCAT_VERSION}" != "${TOMCAT_VERSION}" ]; then
	echo " Tomcat version ${COLOR_GREY}${DETECTED_TOMCAT_VERSION}${COLOR_RESET} does not match expected version ${COLOR_GREY}${TOMCAT_VERSION}${COLOR_RESET}"
	exit 1
fi
