#!/bin/bash

if [ $# -eq 0 ]; then
  IROHA_NAME="iroha-build"
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

  echo "# docker run -d --name ${IROHA} -v ${HOME}/../iroha/config${IROHA_NO}:/usr/local/iroha/config hyperledger/${IROHA_NAME} /bin/su - iroha -c \"env IROHA_HOME=/usr/local/iroha /usr/local/iroha/bin/iroha-main\""

  docker run -d --name ${IROHA} \
    -v ${HOME}/../iroha/config${IROHA_NO}:/usr/local/iroha/config \
    hyperledger/${IROHA_NAME} \
    /bin/su - iroha -c \
    "env IROHA_HOME=/usr/local/iroha /usr/local/iroha/bin/iroha-main"
done
