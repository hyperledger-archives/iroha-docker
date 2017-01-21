#!/bin/bash

NET="172.17.0"

if [ $# -eq 0 ]; then
  HOST=2
else
  HOST=$1
fi

DOMAIN="iroha"
NAME="iroha${HOST}"

echo "POST    \"${NET}.${HOST}:1204\" \"/asset/operation\""
echo "REQUEST {\"command\":\"add\",\"domain\":\"${DOMAIN}\",\"name\":\"${NAME}\"}"
echo -n "REPLY   "

curl -X POST http://${NET}.${HOST}:1204/asset/operation -d"{\"command\":\"add\",\"domain\":\"${DOMAIN}\",\"name\":\"${NAME}\"}"

exit 0
