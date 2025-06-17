#!/usr/bin/env bash
# shellcheck disable=SC2155
set -e -o functrace
if [[ ${BASH_SOURCE[0]} == "${0}" ]]; then
	echo "This script is intended to be sourced, not executed directly."
	exit 1
fi

export DIR
# Some colour codes.
export COLOR_RESET=$(tput sgr0)
export COLOR_GREEN=$(tput setaf 2)
export COLOR_RED=$(tput setaf 9)
export COLOR_BLUE=$(tput setaf 4)
export COLOR_YELLOW=$(tput setaf 3)
export COLOR_GREY=$(tput setaf 8)

set_dir_name() {
	local dir_name="${PROCESS_NAME:-$(basename "$(dirname "$(readlink -f "$0")")")}"
	local color=${PROCESS_COLOR:-$(echo $dir_name | cksum | awk '{print $1%230 + 1}')}
	DIR="$(tput setaf "$color")$dir_name$(tput sgr0)"
}

failure() {
	local lineno=$1
	local msg=$2
	echo "${COLOR_RED}Failed at $lineno: $msg ${COLOR_RESET}" 1>&2
}
trap 'failure ${LINENO} "$BASH_COMMAND"' ERR

set_dir_name

# if /app exists, change to it.
if [ -d /app ]; then
	cd /app
fi
