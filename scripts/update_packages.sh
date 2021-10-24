#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"


if [[ -z "$1" ]]; then
  echo "Please provide a package."
  exit 1
else
  PACKAGE=$1
fi

if [[ -z $2 ]]; then
  echo "Please provide a file path."
  exit 1
elif [[ ! -f $2 ]]; then
  echo "No file found at ${2}"
  exit 1
else
  FILE=$2
fi

VERSION_STRING=$($SCRIPT_DIR/latest_versions.sh $PACKAGE ${MAX_VERSIONS:-10} | $SCRIPT_DIR/versions_to_yaml.sh -)
sed -i 's/package_versions:.*/package_versions: '"${VERSION_STRING}"'/' $FILE

LATEST_VERSION_STRING=$($SCRIPT_DIR/latest_versions.sh $PACKAGE 1)
sed -i 's/package_latest_version:.*/package_latest_version: \"'"${LATEST_VERSION_STRING}"'\"/' $FILE
