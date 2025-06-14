#!/bin/bash
set -eu
source /usr/local/share/common.sh

DETECTED_NGINX_VERSION=$(nginx -v 2>&1 | cut -d'/' -f2 | cut -d'.' -f1-2)

echo -e "Nginx version\n detected: ${COLOR_GREY}${DETECTED_NGINX_VERSION}${COLOR_RESET}\n expected: ${COLOR_GREY}${NGINX_VERSION}${COLOR_RESET}"
if [ "${DETECTED_NGINX_VERSION}" != "${NGINX_VERSION}" ]; then
	echo " Nginx version ${COLOR_GREY}${DETECTED_NGINX_VERSION}${COLOR_RESET} does not match expected version ${COLOR_GREY}${NGINX_VERSION}${COLOR_RESET}"
	exit 1
fi
