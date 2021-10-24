#!/usr/bin/env bash
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

export PACKAGE_VERSIONS=$($SCRIPT_DIR/latest_versions.sh $PACKAGE ${MAX_VERSIONS:-10})

python $SCRIPT_DIR/../readme_builder.py
