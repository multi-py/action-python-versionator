#!/usr/bin/env bash

set -e

if [[ $SKIP_README == "true" ]]; then
  echo "Generation of README.md is disabled."
  exit 0
fi

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export PACKAGE_VERSIONS=$($SCRIPT_DIR/latest_versions.py $PACKAGE ${MAX_VERSIONS:-10})

if [[ -z $1 ]]; then
  echo "Please provide a file path."
  exit 1
elif [[ $1 == "-" ]]; then
  python $SCRIPT_DIR/../readme_builder.py
  exit 0
else
  FILE=$1
fi

python $SCRIPT_DIR/../readme_builder.py > $1

# If TOC tag is in the readme generate and add the TOC.
if grep -q "<\!\-\-ts\-\->" "$1"; then
  $SCRIPT_DIR/gh-md-toc --insert --no-backup --hide-footer $1
fi
