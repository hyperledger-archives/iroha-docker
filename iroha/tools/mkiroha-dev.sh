#!/bin/bash

docker stop iroha-dev

docker rm iroha-dev

if [ ! -d /opt/iroha ]; then
  mkdir /opt/iroha
fi

docker run -d --name iroha-dev -v /opt/iroha:/var/tmp/iroha hyperledger/iroha /usr/local/iroha/iroha-out.sh

rsync -av ../config /opt/iroha

cd /opt/iroha

chown -R 168:168 config
chmod g-s config/config?
chmod 0755 config/config?

exit 0
