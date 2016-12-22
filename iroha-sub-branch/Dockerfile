#-----------------------------------------------------------------------
# iroha - IROHA container
#
# build : docker build -t hyperledger/iroha .
#
# Copyright (c) 2016 Soramitsu,Co.,Ltd.
# All Rights Reserved.
#-----------------------------------------------------------------------
FROM hyperledger/iroha-dev

ARG BRANCH=${BRANCH:-master}

RUN echo " clone branch: ${BRANCH}"

MAINTAINER Takeshi Yonezu <yonezu@soramitsu.co.jp> / Taisei Igarashi <igarashi@soramitsu.co.jp>

LABEL BUILD="docker build -t hyperledger/iroha-sub-branch ."
LABEL RUN="docker run -d --name iroha hyperledger/iroha-sub-branch"

USER root

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV IROHA_HOME /opt/iroha

WORKDIR /opt
RUN git clone -b ${BRANCH} --recursive https://github.com/hyperledger/iroha.git iroha; \
    apt -y install autoconf automake libtool pkg-config

WORKDIR /tmp
RUN git clone -b v3.0.0 https://github.com/google/protobuf.git

WORKDIR /tmp/protobuf
RUN (git cherry-pick 1760feb621a913189b90fe8595fffb74bce84598; echo Force continue) && \
  ./autogen.sh && \
  ./configure --prefix=/usr && \
  make -j 14 && \
  make install

WORKDIR /tmp
RUN git clone -b $(curl -L http://grpc.io/release) https://github.com/grpc/grpc

WORKDIR /tmp/grpc
RUN git submodule update --init && \
  make && \
  make install

WORKDIR $IROHA_HOME/core/vendor/leveldb
RUN make
WORKDIR $IROHA_HOME/core/vendor/ed25519
RUN make
WORKDIR $IROHA_HOME/core/vendor/KeccakCodePackage
RUN make && make generic64/libkeccak.a
WORKDIR $IROHA_HOME/core/infra/crypto
RUN make

RUN mkdir $IROHA_HOME/build
WORKDIR $IROHA_HOME/build
RUN cmake ..
RUN make

ENV IROHA_HOME /usr/local/iroha

RUN mkdir $IROHA_HOME && \
    rsync -av /opt/iroha/build/bin $IROHA_HOME && \
##  rsync -av /opt/iroha/config $IROHA_HOME && \
    rsync -av /opt/iroha/build/lib $IROHA_HOME && \
    rsync -av /opt/iroha/build/my_test_bin $IROHA_HOME && \
    rsync -av /opt/iroha/build/test_bin $IROHA_HOME && \
    rsync -av /opt/iroha/core/vendor/ed25519/lib $IROHA_HOME

COPY ./test.sh ./mkiroha-tar.sh ${IROHA_HOME}/

RUN sed -i 's/\/opt\/iroha/\/usr\/local\/iroha/' /home/iroha/.bashrc && \
    sed -i 's/\/opt\/iroha/\/usr\/local\/iroha/' /root/.bashrc

## USER iroha
WORKDIR $IROHA_HOME

CMD ["/bin/su","-","iroha","-c","env IROHA_HOME=/usr/local/iroha /usr/local/iroha/bin/iroha-main"]
