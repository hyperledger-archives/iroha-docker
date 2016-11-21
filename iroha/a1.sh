#!/bin/bash

docker stop iroha1
docker rm iroha1

docker run -it --name iroha1 --shm-size 1g \
  -v /Users/yonezu/git/soramitsu/Dockerfiles.git/iroha/config1:/opt/iroha/config \
  soramitsu/iroha /bin/bash
