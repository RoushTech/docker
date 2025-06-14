#!/bin/bash
source /usr/local/share/common.sh

# Verify the PATH we set is sane
if [ ! -d "$JAVA_HOME" ]; then
	echo "Java installation failed, $JAVA_HOME does not exist"
	exit 1
fi

DETECTED_JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d'.' -f1)
if [ "${DETECTED_JAVA_VERSION}" = "1" ]; then
	DETECTED_JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d'.' -f1-2)
fi

echo -e "Java version\n detected: ${COLOR_GREY}${DETECTED_JAVA_VERSION}${COLOR_RESET}\n expected: ${COLOR_GREY}${JAVA_VERSION}${COLOR_RESET}"
if [ "${DETECTED_JAVA_VERSION}" != "${JAVA_VERSION}" ]; then
	echo " Java version ${COLOR_GREY}${DETECTED_JAVA_VERSION}${COLOR_RESET} does not match expected version ${COLOR_GREY}${JAVA_VERSION}${COLOR_RESET}"
	exit 1
fi
