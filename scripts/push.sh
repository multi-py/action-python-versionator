#!/usr/bin/env bash

if [[ git diff --quiet --exit-code "$ACTION_PATH" ]]; then
  echo "No differences found."
  exit 0
fi

git config --local user.name "$GIT_USER"
git config --local user.email "$GIT_EMAIL"
git add "$ACTION_PATH"
git commit -m "Versionator Updating versions for python and package."
