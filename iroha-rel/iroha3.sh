#!/bin/bash

IROHA_NO="3"
IROHA="iroha${IROHA_NO}"

HOME=$(pwd)

docker stop ${IROHA}
docker rm ${IROHA}

docker run -it --name ${IROHA} --shm-size 1g \
  -v ${HOME}/config${IROHA_NO}:/usr/local/iroha/config \
  hyperledger/iroha-rel /bin/bash
