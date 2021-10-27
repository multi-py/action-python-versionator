#!/usr/bin/env bash

# Silly OSX
if which ggrep > /dev/null; then
  GREP=ggrep
else
  GREP=grep
fi

curl -sL https://pypi.org/simple/$1/ | $GREP -oh '[[:digit:]]*\.[[:digit:]]*\.[[:digit:]].**[\.whl|\.tar\.gz]<' | cut -d"." -f 1,2,3 | cut -d"-" -f 1 | uniq | tail -${2:-10}
