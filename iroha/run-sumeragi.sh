#!/bin/bash

HOME=$(pwd)

IROHA_NO="3"
IROHA="iroha${IROHA_NO}"

docker stop ${IROHA}
docker rm ${IROHA}

docker run -it --name ${IROHA} \
  -v ${HOME}/config${IROHA_NO}:/usr/local/iroha/config \
  hyperledger/iroha /bin/bash
