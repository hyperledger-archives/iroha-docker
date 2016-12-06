#!/bin/bash

HOME=$(pwd)

IROHA_NO="3"
IROHA="iroha${IROHA_NO}"

echo "# docker stop ${IROHA}"
docker stop ${IROHA}

echo "# docker rm ${IROHA}"
docker rm ${IROHA}

echo "# docker run -it --name ${IROHA} -v ${HOME}/config${IROHA_NO}:/usr/local/iroha/config hyperledger/iroha /bin/bash"

docker run -it --name ${IROHA} \
  -v ${HOME}/config${IROHA_NO}:/usr/local/iroha/config \
  hyperledger/iroha /bin/bash
