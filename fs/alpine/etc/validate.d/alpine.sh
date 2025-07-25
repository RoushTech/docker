#!/bin/bash
source /usr/local/share/common.sh
DETECTED_ALPINE_VERSION=$(cat /etc/os-release | grep -E 'VERSION_ID' | cut -d'=' -f2 | tr -d '"' | cut -d'.' -f1-2)
EXPECTED_APP_USER_HOME_PATH="/home"
EXPECTED_EXECUTABLES=(
	"stat" "mkdir" "rmdir" # Needed by docker compose watch
	"nano" "vim"
	"curl" "wget"                                # HTTP tools
	"tar" "gzip" "bzip2" "xz"                    # Archive tools
	"ping" "traceroute" "ping" "ifconfig" "host" # Network tools
	"runit" "sv" "chpst" "runsv" "runsvdir"      # Runit and friends
	"dos2unix" "patch"
)
FAILURE=0

echo -e "Alpine version\n detected: ${COLOR_GREY}${DETECTED_ALPINE_VERSION}${COLOR_RESET}\n expected: ${COLOR_GREY}${ALPINE_VERSION}${COLOR_RESET}"
if [ "${DETECTED_ALPINE_VERSION}" != "${ALPINE_VERSION}" ]; then
	echo " Alpine version ${COLOR_GREY}${DETECTED_ALPINE_VERSION}${COLOR_RESET} does not match expected version ${COLOR_GREY}${ALPINE_VERSION}${COLOR_RESET}"
	FAILURE=1
fi

DETECTED_APP_USER_HOME_PATH=$(cat /etc/passwd | grep app | cut -d':' -f 6)
if [ "${DETECTED_APP_USER_HOME_PATH}" != "${EXPECTED_APP_USER_HOME_PATH}" ]; then
	echo " App user home path ${COLOR_GREY}${DETECTED_APP_USER_HOME_PATH} does not match expected path ${COLOR_GREY}${EXPECTED_APP_USER_HOME_PATH}${COLOR_RESET}"
	FAILURE=1
fi

if [ "$SYSTEM_USER" != "app" ]; then
	echo "System user should be 'app', but is '${SYSTEM_USER}'"
	FAILURE=1
fi

for executable in "${EXPECTED_EXECUTABLES[@]}"; do
	if ! command -v "$executable" &>/dev/null; then
		echo "Executable ${COLOR_GREY}${executable}${COLOR_RESET} is not found in the system"
		FAILURE=1
	fi
done

exit $FAILURE
