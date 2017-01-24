#!/bin/bash

VENDOR="hyperledger"

IH_NAME="iroha"

IROHA_HOME="/opt/iroha"

if [ "$(uname -s)" == "Linux" ]; then
  IH_HOME="${IROHA_HOME}"
else
  IH_HOME="${HOME}/iroha"
fi

NO="3"
IROHA="iroha${NO}"

IH_NET="iroha_net"
IH_SUBNET="10.0.168.0/24"
IH_IP=$(echo "$(echo ${IH_SUBNET} | cut -d'.' -f1-3).$((NO+1))")

echo "# docker stop ${IROHA}"
docker stop ${IROHA}

echo "# docker rm ${IROHA}"
docker rm ${IROHA}

echo "# docker run -it --name ${IROHA} -v ${IH_HOME}/config/config${NO}:${IH_HOME}/config -v ${IH_HOME}/ledger/iroha_ledger${NO}:/tmp/iroha_ledger --network=${IH_NET} --ip=${IH_IP} ${VENDOR}/${IH_NAME} /bin/bash"

docker run -it --name ${IROHA} \
  -v ${IH_HOME}/config/config${NO}:${IH_HOME}/config \
  -v ${IH_HOME}/ledger/iroha_ledger${NO}:/tmp/iroha_ledger \
  --network=${IH_NET} --ip=${IH_IP} \
  ${VENDOR}/${IH_NAME} /bin/bash
