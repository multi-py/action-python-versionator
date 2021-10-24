#!/usr/bin/env bash

git config --local user.name "$GIT_USER"
git config --local user.email "$GIT_EMAIL"

git add "$ACTION_PATH"
git add "$README_PATH"


if [[ ! -z $(git status -s) ]]; then
  git commit -m "Versionator Updating versions for python and package."
  git push
else
  echo "No updates to push."
  exit 0
fi

