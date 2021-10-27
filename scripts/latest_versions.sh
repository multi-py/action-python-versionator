#!/usr/bin/env bash

# Silly OSX
if which ggrep > /dev/null; then
  GREP=ggrep
else
  GREP=grep
fi

if [[ "$INCLUDE_PRERELEASE" == "true" ]]; then
  curl -sL https://pypi.org/simple/$1/ | $GREP -oh '[[:digit:]]*\.[[:digit:]]*\.[[:digit:]].**[\.whl|\.tar\.gz]<' | cut -d"." -f 1,2,3 | cut -d"-" -f 1 | uniq | tail -${2:-10}
else
  curl -sL https://pypi.org/simple/$1/ | $GREP -oh '[[:digit:]]*\.[[:digit:]]*\.[[:digit:]].**[\.whl|\.tar\.gz]<' | cut -d"." -f 1,2,3 | cut -d"-" -f 1 | cut -d"b" -f 1 | cut -d"a" -f 1 | uniq | tail -${2:-10}
fi
