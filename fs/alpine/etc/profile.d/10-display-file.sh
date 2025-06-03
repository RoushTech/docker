#!/usr/bin/env bash
function display_file() {
  # Check if the file exists
  if [ ! -f "$1" ]; then
    echo "File ${1} not found!" > /dev/stderr
    return 1
  fi

  # Check if the file is empty
  if [ ! -s "$1" ]; then
    echo "File ${1} is empty!" > /dev/stderr
    return 1
  fi

  cat $1 | while read line; do echo "${colour_grey}[$(basename $1)] ${colour_ltgrey}${line}${colour_reset}"; done
}