#!/bin/bash
DETECTED_NODE_VERSION=$(node --version | cut -d'.' -f1 | sed 's/v//')
DETECTED_YARN_VERSION=$(yarn --version | cut -d'.' -f1-2)
DETECTED_NPM_VERSION=$(npm --version | cut -d'.' -f1)
FAILURE=0

echo -e "Node.js version\n detected: ${COLOR_GREY}${DETECTED_NODE_VERSION}${COLOR_RESET}\n expected: ${COLOR_GREY}${NODE_VERSION}${COLOR_RESET}"
if [ "${DETECTED_NODE_VERSION}" != "${NODE_VERSION}" ]; then
	echo " Node.js version ${COLOR_GREY}${DETECTED_NODE_VERSION}${COLOR_RESET} does not match expected version ${COLOR_GREY}${NODE_VERSION}${COLOR_RESET}"
	FAILURE=1
fi

echo -e "Yarn version\n detected: ${COLOR_GREY}${DETECTED_YARN_VERSION}${COLOR_RESET}\n expected: ${COLOR_GREY}${YARN_VERSION}${COLOR_RESET}"
if [ "${DETECTED_YARN_VERSION}" != "${YARN_VERSION}" ]; then
	echo " Yarn version ${COLOR_GREY}${DETECTED_YARN_VERSION}${COLOR_RESET} does not match expected version ${COLOR_GREY}${YARN_VERSION}${COLOR_RESET}"
	FAILURE=1
fi

echo -e "NPM version\n detected: ${COLOR_GREY}${DETECTED_NPM_VERSION}${COLOR_RESET}\n expected: ${COLOR_GREY}${NPM_VERSION}${COLOR_RESET}"
if [ "${DETECTED_NPM_VERSION}" != "${NPM_VERSION}" ]; then
	echo " NPM version ${COLOR_GREY}${DETECTED_NPM_VERSION}${COLOR_RESET} does not match expected version ${COLOR_GREY}${NPM_VERSION}${COLOR_RESET}"
	FAILURE=1
fi

# Detect badly owned files in the NPM cache directory
NUMBER_OF_BAD_FILES=$(find $NPM_CACHE_DIR -not -user $SYSTEM_USER | wc -l)
echo -n "NPM cache directory ownership check: "
if [ $NUMBER_OF_BAD_FILES -gt 0 ]; then
	echo -e "${COLOR_RED}FAIL${COLOR_RESET}"
	echo "Bad files:"
	find $NPM_CACHE_DIR -not -user $SYSTEM_USER -exec ls -lah {} \;
	FAILURE=1
else
	echo -e "${COLOR_GREEN}OK${COLOR_RESET}"
fi

exit $FAILURE
