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

  echo "# docker stop ${IROHA}"
  docker stop ${IROHA}

  echo "# docker rm ${IROHA}"
  docker rm ${IROHA}

  if [ $i -eq 4 ]; then
  echo "# docker run -d --name ${IROHA} -p1204:1204 -v ${HOME}/config${IROHA_NO}:/usr/local/iroha/config hyperledger/${IROHA_NAME}"

  docker run -d --name ${IROHA} -p1204:1204 \
    -v ${HOME}/config${IROHA_NO}:/usr/local/iroha/config \
    hyperledger/${IROHA_NAME}
  else
  echo "# docker run -d --name ${IROHA} -v ${HOME}/config${IROHA_NO}:/usr/local/iroha/config hyperledger/${IROHA_NAME}"

  docker run -d --name ${IROHA} \
    -v ${HOME}/config${IROHA_NO}:/usr/local/iroha/config \
    hyperledger/${IROHA_NAME}
  fi
done
