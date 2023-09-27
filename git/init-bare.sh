#!/bin/bash

POST_RECEIVE_FILE_NAME="adonis-5.sh"

for arg in "$@"; do
  if [[ "$arg" == "-file="* ]]; then
    POST_RECEIVE_FILE_NAME="${arg#*=}"
  fi
done

git init --bare
cd hooks

POST_RECEIVE_FILE_URL="https://raw.githubusercontent.com/fatasy/server-shell-helps/main/git/post-receive/$POST_RECEIVE_FILE_NAME"
POST_RECEIVE_FILE_DESTINATION_DIR="$(pwd)/post-receive"

curl -sSfO "$POST_RECEIVE_FILE_URL"

if [ $? -eq 0 ]; then
  mv "$POST_RECEIVE_FILE_NAME" "$POST_RECEIVE_FILE_DESTINATION_DIR"
  echo "post-receive created"
else
  echo "Failed to download post-receive file."
fi

chmod +x post-receive
