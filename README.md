# Dockerfiles
Dockerfiles for IROHA

These are Dockerfile for IROHA development.

1. iroha-dev

Base image for IROHA. This is based on Ubuntu 16.04 official container.

2. iroha

IROHA running container. Instruction is as below.

``` bash
su - iroha
bash /start_iroha.sh

cd /opt/iroha/build
./bin/iroha-main
```

At first you should make sumeragi.json file for your IROHA network.

Enjoy with your IROHA!!

Copyright (c) 2016 Soramitsu,Co.,Ltd.
All Rights Reserved.
