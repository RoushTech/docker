#!/usr/bin/env bash
DIR="magento-images"
source $(dirname "$0")/common
(
	echo "Generating Magento Catalog Images"
	magento catalog:image:resize --async --quiet --skip_hidden_images
) 2>&1 | (while IFS= read -r; do echo "${COLOR_RESET}[${DIR}] $REPLY"; done)
