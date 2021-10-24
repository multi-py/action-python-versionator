#!/usr/bin/env bash

if [[ "$1" == "-" ]]; then
  VERSIONS=$(cat)
else
  VERSIONS=$1
fi

STRING="["
for ELEMENT in $VERSIONS; do
  STRING+="\"${ELEMENT}\", "
done
STRING=${STRING::-2}
STRING+="]"
echo "$STRING"
