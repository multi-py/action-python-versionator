#!/usr/bin/env bash

git config --local user.name "$GIT_USER"
git config --local user.email "$GIT_EMAIL"

if ! git diff --quiet --exit-code "$ACTION_PATH" ; then
  git add "$ACTION_PATH"
  HAS_UPDATES=true
fi

if ! git diff --quiet --exit-code "$README_PATH" ; then
  git add "$README_PATH"
  HAS_UPDATES=true
fi

if [[ "$HAS_UPDATES" != "true" ]]; then
  echo "No updated to push."
  exit 1
fi

git commit -m "Versionator Updating versions for python and package."
git push
