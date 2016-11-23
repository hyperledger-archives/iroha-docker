#!/bin/bash

IROHA_NO="1"
IROHA="iroha${IROHA_NO}"

HOME=$(pwd)

docker stop ${IROHA}
docker rm ${IROHA}

docker run -it --name ${IROHA} --shm-size 512m \
  -v ${HOME}/config${IROHA_NO}:/usr/local/iroha/config \
  soramitsu/iroha-rel /bin/bash 
