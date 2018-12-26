#!/bin/sh

if [ ! -n "$PUBLIC_PATH" ]; then
  PUBLIC_PATH=public
fi
if [ ! -n "$GITHUB_TOKEN" ]; then
  echo "You need to supply GITHUB_TOKEN"
fi

git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"

gh-pages -d $PUBLIC_PATH -b gh-pages --dotfiles=true

curl --request POST -H "Authorization: token ${GITHUB_TOKEN}" \
  --url "https://api.github.com/repos/$GITHUB_REPOSITORY/pages/builds" \
  --header 'accept:   application/vnd.github.mister-fantastic-preview+json'
