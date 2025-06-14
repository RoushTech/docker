#!/bin/bash
source /usr/local/share/common.sh
WAR_MACHINE_SERVICE_DIR="/etc/services.d/war-machine"

echo -n "Checking Java is configured to run ${COLOR_YELLOW}.war${COLOR_RESET} tasks ... "
if [ ! -d "${WAR_MACHINE_SERVICE_DIR}" ]; then
	echo "[$COLOR_RED}FAIL$COLOR_RESET}]"
	echo " > War machine service directory ${COLOR_YELLOW}${WAR_MACHINE_SERVICE_DIR}${COLOR_RESET}does not exist."
	exit 1
else
	echo "[${COLOR_GREEN}DONE${COLOR_RESET}]"
fi
