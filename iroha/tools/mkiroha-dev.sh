#!/bin/bash

docker stop iroha-dev

docker rm iroha-dev

IROHA_HOME="/opt/iroha"

if [ "$(uname -s)" == "Linux" ]; then
  IH_HOME="${IROHA_HOME}"
else
  IH_HOME="${HOME}/iroha"
fi

IH_UID=168
IH_GID=168

if [ ! -d ${IH_HOME} ]; then
  mkdir ${IH_HOME}
fi

docker run -it --rm --name iroha-dev -v ${IH_HOME}:/var/tmp/iroha hyperledger/iroha ${IROHA_HOME}/iroha-out.sh

rsync -av ../config ${IH_HOME}

if [ "$(uname -s)" == "Linux" ]; then
 cd ${IROHA_HOME}

 chown -R ${IH_UID}:${IH_GID} config
 chmod g-s config/config?
 chmod 0755 config/config?
fi

exit 0
