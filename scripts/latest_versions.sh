#!/usr/bin/env bash

VERSIONS=$(curl -sL https://pypi.org/simple/$1/ | grep -Eoi '>[a-zA-Z]+-.+?\.tar\.gz<' | grep -Eoi '\d+(\.\d+)+((a|b|rc)\d?)?' | tail -${2:-10})
echo $VERSIONS
