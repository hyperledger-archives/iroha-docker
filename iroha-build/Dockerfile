#-----------------------------------------------------------------------
# iroha-build - IROHA building container
#
# build : docker build -t soramitsu/iroha-build .
#
# Copyright (c) 2016 Soramitsu,Co.,Ltd.
# All Rights Reserved.
#-----------------------------------------------------------------------
FROM ubuntu

MAINTAINER Takeshi Yonezu <yonezu@soramitsu.co.jp>

LABEL BUILD="docker build -t soramitsu/iroha-build ."

USER root

COPY ./iroha_prep.sh  /usr/local/bin/iroha_prep.sh
COPY ./iroha_build.sh /usr/local/bin/iroha_build.sh
COPY ./start_iroha.sh /usr/local/bin/start_iroha.sh
COPY ./test.sh        /usr/local/bin/test.sh
RUN  chmod 0755       /usr/local/bin/test.sh

CMD ["/bin/bash"]
