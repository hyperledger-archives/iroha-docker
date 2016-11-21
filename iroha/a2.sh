#!/bin/bash

docker stop iroha2
docker rm iroha2

docker run -it --name iroha2 --shm-size 1g \
  -v /Users/yonezu/git/soramitsu/Dockerfiles.git/iroha/config2:/opt/iroha/config \
  soramitsu/iroha /bin/bash
