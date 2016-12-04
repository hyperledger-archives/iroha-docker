#-----------------------------------------------------------------------
# iroha-build - IROHA building container
#
# build : docker build -t hyperledger/iroha-build .
#
# Copyright (c) 2016 Soramitsu,Co.,Ltd.
# All Rights Reserved.
#-----------------------------------------------------------------------
FROM ubuntu

MAINTAINER Takeshi Yonezu <yonezu@soramitsu.co.jp>

LABEL BUILD="docker build -t hyperledger/iroha-build ."

USER root

COPY iroha_prep.sh iroha_build.sh test.sh /usr/local/iroha/

CMD ["/bin/bash"]
