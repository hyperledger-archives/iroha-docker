#!/bin/bash

#-----------------------------------------------------------------------
# run-iroha-build.sh - run iroha-build container
#
# Copyright (c) 2016 Soramitsu,Co.,Ltd.
# All Rights Reserved.
#-----------------------------------------------------------------------

docker stop iroha-build
docker rm iroha-build

docker run -it --name iroha-build \
  -v /var/tmp:/var/tmp \
  --shm-size 512m soramitsu/iroha-build /bin/bash
