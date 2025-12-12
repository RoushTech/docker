#!/bin/bash
set -eu
source /usr/local/share/common.sh

DETECTED_DOTNET_VERSION=$(dotnet --version | cut -d'.' -f1-2)

echo -e ".NET version\n detected: ${COLOR_GREY}${DETECTED_DOTNET_VERSION}${COLOR_RESET}\n expected: ${COLOR_GREY}${DOTNET_VERSION}${COLOR_RESET}"
if [ "${DETECTED_DOTNET_VERSION}" != "${DOTNET_VERSION}" ]; then
	echo " .NET version ${COLOR_GREY}${DETECTED_DOTNET_VERSION}${COLOR_RESET} does not match expected version ${COLOR_GREY}${DOTNET_VERSION}${COLOR_RESET}"
	exit 1
fi
