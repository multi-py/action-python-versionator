#!/usr/bin/env bash

# Silly OSX
if which ggrep > /dev/null; then
  GREP=ggrep
else
  GREP=grep
fi

VERSIONS=$(curl -sL https://pypi.org/simple/$1/ | $GREP -oh '[[:digit:]]*\.[[:digit:]]*\.[[:digit:]]*\.tar\.gz<' | cut -d"." -f 1,2,3 | tail -${2:-10})
echo $VERSIONS
