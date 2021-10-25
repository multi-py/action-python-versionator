#!/usr/bin/env bash

export README_TEMPLATE=./templates/README.md
export PROJECT_NAME="Testing"
export PACKAGE="uvicorn"
export PACKAGE_VERSIONS="0.13.3 0.13.4 0.14.0 0.15.0"
export PYTHON_VERSIONS="3.6 3.7 3.8 3.9 3.10"
export ORGANIZATION="TestOrganization"
export REPOSITORY="TestOrganization/TestRepository"

./scripts/update_readme.sh -
