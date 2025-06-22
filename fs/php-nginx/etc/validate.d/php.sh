#!/bin/bash
set -eu
source /usr/local/share/common.sh

DETECTED_PHP_VERSION=$(php --version | head -n 1 | cut -d' ' -f2 | cut -d'.' -f1-2)

echo -e "PHP version\n detected: ${COLOR_GREY}${DETECTED_PHP_VERSION}${COLOR_RESET}\n expected: ${COLOR_GREY}${PHP_VERSION}${COLOR_RESET}"
if [ "${DETECTED_PHP_VERSION}" != "${PHP_VERSION}" ]; then
	echo " PHP version ${COLOR_GREY}${DETECTED_PHP_VERSION}${COLOR_RESET} does not match expected version ${COLOR_GREY}${PHP_VERSION}${COLOR_RESET}"
	exit 1
fi

EXPECTED_PHP_EXTENSIONS=("bcmath" "curl" "dom" "fileinfo" "gd" "intl" "json" "mbstring" "mysqli" "openssl" "redis" "pdo_mysql" "pdo_pgsql" "soap" "xml" "zip")
MODULES_DETECTED=$(php -m | tr '\n' ' ')
MODULE_CHECK=true
for EXTENSION in "${EXPECTED_PHP_EXTENSIONS[@]}"; do
	if [[ ! ${MODULES_DETECTED} =~ ${EXTENSION} ]]; then
		echo -e " PHP extension ${COLOR_GREY}${EXTENSION}${COLOR_RESET} is not installed."
		MODULE_CHECK=false
	fi
done
if [ "${MODULE_CHECK}" = false ]; then
	echo " Detected PHP modules: ${COLOR_GREY}${MODULES_DETECTED}${COLOR_RESET}"
	echo " Expected PHP modules: ${COLOR_GREY}$(printf '%s ' "${EXPECTED_PHP_EXTENSIONS[@]}")${COLOR_RESET}"
	exit 1
else
	echo -e " PHP modules check passed: ${COLOR_GREEN}OK${COLOR_RESET}"
fi

if [ -d /var/log/php ]; then
	echo "Directory ${COLOR_GREY}/var/log/php${COLOR_RESET} should not exist."
	exit 1
fi
if [ -f /var/log/php_error.log ]; then
	echo "File ${COLOR_GREY}/var/log/php_error.log${COLOR_RESET} exists."
else
	echo "File ${COLOR_GREY}/var/log/php_error.log${COLOR_RESET} does not exist."
	exit 1
fi
if [ -f /var/log/php_access.log ]; then
	echo "File ${COLOR_GREY}/var/log/php_access.log${COLOR_RESET} exists."
else
	echo "File ${COLOR_GREY}/var/log/php_access.log${COLOR_RESET} does not exist."
	exit 1
fi
