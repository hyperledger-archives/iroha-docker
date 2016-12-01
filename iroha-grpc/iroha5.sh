#!/bin/bash

IROHA_NO="5"
IROHA="iroha${IROHA_NO}"

HOME=$(pwd)

docker stop ${IROHA}
docker rm ${IROHA}

docker run -it --name ${IROHA} \
  -v ${HOME}/config${IROHA_NO}:/usr/local/iroha/config \
  hyperledger/iroha /bin/bash
