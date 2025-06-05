#!/usr/bin/env bash
# shellcheck disable=SC2155
set -eE -o functrace

failure() {
	local lineno=$1
	local msg=$2
	echo "${COLOR_RED}Failed at $lineno: $msg ${COLOR_RESET}" 1>&2
}
trap 'failure ${LINENO} "$BASH_COMMAND"' ERR
if [[ ${BASH_SOURCE[0]} == "${0}" ]]; then
	echo "This script is intended to be sourced, not executed directly."
	exit 1
fi

cd "$(dirname "$0")" || exit 1

DIRECTORY="$(realpath $PWD)"
DIR=$(basename "$DIRECTORY")
MULTIARCH_BUILDER_NAME="multiarch-${DIR,,}"
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1
export TERM=${TERM:-xterm-256color}
export COLOR_RESET=$(tput sgr0)
export COLOR_GREEN=$(tput setaf 2)
export COLOR_RED=$(tput setaf 9)
export COLOR_YELLOW=$(tput setaf 3)
export COLOR_GREY=$(tput setaf 8)

function pushd() {
	command pushd "$@" >/dev/null
}
function popd() {
	command popd >/dev/null
}
function builder_exists() {
	if [ "$(docker buildx ls --format "{{.Name}}" | grep -c "^${MULTIARCH_BUILDER_NAME}$")" -eq "1" ]; then
		return 0
	fi
	return 1
}
function builder_init() {
	if [ ! -x "$(command -v docker buildx)" ]; then
		echo "Docker Buildx is not installed. Please install it first."
		exit 1
	fi

	if ! builder_exists; then
		echo -n "Creating multiarch builder ($MULTIARCH_BUILDER_NAME) ..."
		docker buildx create --name $MULTIARCH_BUILDER_NAME --driver docker-container --use >/dev/null || true
		if [ $? -eq 0 ]; then
			echo " done."
		else
			echo " failed."
			exit 1
		fi
	fi
}
function builder_destroy() {
	if builder_exists; then
		echo -n "Removing multiarch builder ($MULTIARCH_BUILDER_NAME) ..."
		docker buildx rm -q $MULTIARCH_BUILDER_NAME >/dev/null 2>&1 || true
		if [ $? -eq 0 ]; then
			echo " done."
		else
			echo " failed."
			exit 1
		fi
	fi
}
function ring_bell() {
	if [ ! -z "${NOBELL+x}" ]; then
		# if NOBELL is set, do not ring the bell
		return 0
	fi

	if [ -x "$(command -v bell)" ]; then
		# if $1 is set, use it as the message
		if [ -n "${1-}" ]; then
			bell "$1"
		else
			bell
		fi
	fi
}
function banner() {
	# if figlet is installed, use it to display a banner
	if [ -x "$(command -v figlet)" ]; then
		FIGLET_FONT=${FIGLET_FONT:-slant}
		COLS=$(/usr/bin/tput cols) || 160

		figlet -w $COLS -f $FIGLET_FONT "$@" | lolcat || figlet -w $COLS -f $FIGLET_FONT "$@"
	else
		echo "**********************************************************"
		echo "   $1"
		echo "**********************************************************"
	fi
}
function colorize() {
	# $1 must be set to the color code
	if [ -z "$1" ]; then
		echo 'Usage: echo "text" | colorize <color_code> '
		return 1
	fi
	(while IFS= read -r; do echo "${1}${REPLY}${COLOR_RESET}"; done)
}
function docker_pull_parallel() {
	SECONDS=0
	echo -n "Pulling ${#} images in parallel ..."
	# Pull images in parallel
	local images=("$@")
	for image in "${images[@]}"; do
		docker pull -q "$image" >/dev/null &
	done
	wait
	echo " [DONE in ${SECONDS}s]"
}
function docker_pull_base_images() {
	local dockerfile="$1"
	if [ ! -f "$dockerfile" ]; then
		echo "Dockerfile not found: $dockerfile"
		exit 1
	fi
	local images=$(grep FROM $dockerfile | cut -f2 -d' ' | grep "/\|:" | sort -u)
	echo "Found ${#images[@]} base images in $dockerfile:"
	for image in $images; do
		echo "  - $image"
	done
	docker_pull_parallel $images
}
function build_parents() {
	if [ ! -d "$BASE_IMAGE_PATH" ]; then
		echo "Parent images directory ($(realpath "$BASE_IMAGE_PATH")) not found. Skipping parent image build."
		exit 1
	else
		pushd "$BASE_IMAGE_PATH"
		banner "Baking Parent Images"
		SECONDS=0
		NOBELL=true ./bake magento
		echo "Baked parent images in ${SECONDS}s"
		popd
	fi
}
function get_new_session_id() {
	SESSION=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 8 | head -n 1)
}
