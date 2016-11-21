#!/bin/bash

docker stop iroha3
docker rm iroha3

docker run -it --name iroha3 --shm-size 1g \
  -v /Users/yonezu/git/soramitsu/Dockerfiles.git/iroha/config3:/opt/iroha/config \
  soramitsu/iroha /bin/bash
