#!/usr/bin/env bash
DIR="magento-install"
source $(dirname "$0")/common
(
	echo "Installing Magento Cron Jobs"
	magento cron:install --force
) 2>&1 | (while IFS= read -r; do echo "${COLOR_RESET}[${DIR}] $REPLY"; done)
