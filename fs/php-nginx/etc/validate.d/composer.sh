#!/bin/bash
set -eu
source /usr/local/share/common.sh

DETECTED_COMPOSER_VERSION=$(composer --version 2>/dev/null | sed -e 's|^Composer version ||g' -e 's|^Composer ||g' | cut -f1 -d' ')

echo -e "Composer version\n detected: ${COLOR_GREY}${DETECTED_COMPOSER_VERSION}${COLOR_RESET}\n expected: ${COLOR_GREY}${COMPOSER_VERSION}${COLOR_RESET}"
if [ "${COMPOSER_VERSION}" = "latest-stable" ]; then
	echo " Composer version is set to 'latest-stable', skipping validation."
	exit 0
fi
if [ "${DETECTED_COMPOSER_VERSION}" != "${COMPOSER_VERSION}" ]; then
	echo " Composer version ${COLOR_GREY}${DETECTED_COMPOSER_VERSION}${COLOR_RESET} does not match expected version ${COLOR_GREY}${COMPOSER_VERSION}${COLOR_RESET}"
	exit 1
fi
