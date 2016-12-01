#!/bin/bash

IROHA_NO="1"
IROHA="iroha${IROHA_NO}"

HOME=$(pwd)

docker stop ${IROHA}
docker rm ${IROHA}

docker run -it --name ${IROHA} --shm-size 1g \
  -v ${HOME}/config${IROHA_NO}:/usr/local/iroha/config \
  -v /var/tmp:/var/tmp \
  hyperledger/iroha /bin/bash 
