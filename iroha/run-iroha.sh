#!/bin/bash

if [ $# -eq 0 ]; then
  IROHA_NAME="iroha"
else
  IROHA_NAME="$1"
fi

HOME=$(pwd)

for i in 1 2 3 4; do
  IROHA_NO="$i"
  IROHA="iroha${IROHA_NO}"

  docker stop ${IROHA}
  docker rm ${IROHA}

  docker run -d --name ${IROHA} \
    -v ${HOME}/config${IROHA_NO}:/usr/local/iroha/config \
    hyperledger/${IROHA_NAME}
done
