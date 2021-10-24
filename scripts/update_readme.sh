#!/usr/bin/env bash
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export PACKAGE_VERSIONS=$($SCRIPT_DIR/latest_versions.sh $PACKAGE ${MAX_VERSIONS:-10})

if [[ -z $1 ]]; then
  echo "Please provide a file path."
  exit 1
elif [[ ! -f $1 ]]; then
  echo "No file found at ${1}"
  exit 1
else
  FILE=$1
fi

python $SCRIPT_DIR/../readme_builder.py > $1
