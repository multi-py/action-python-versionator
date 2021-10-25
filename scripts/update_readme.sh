#!/usr/bin/env bash
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export PACKAGE_VERSIONS=$($SCRIPT_DIR/latest_versions.sh $PACKAGE ${MAX_VERSIONS:-10})

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
