#-----------------------------------------------------------------------
# iroha-rel - IROHA container for Release
#
# build : docker build -t hyperledger/iroha-rel .
#
# Copyright (c) 2016 Soramitsu,Co.,Ltd.
# All Rights Reserved.
#-----------------------------------------------------------------------
FROM ubuntu

MAINTAINER Takeshi Yonezu <yonezu@soramitsu.co.jp>

LABEL BUILD="docker build -t hyperledger/iroha-rel ."
LABEL RUN="docker run -d --name iroha-rel hyperledger/iroha-rel"

USER root

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV IROHA_HOME=/usr/local/iroha

RUN groupadd -g 168 iroha && \
    useradd -u 168 -c "IROHA Administrator" -s /bin/bash -m -d /usr/local/iroha -p $(perl -e "print(crypt('passw0rd', 'sa'));") -g iroha iroha && \
    usermod -G adm,sudo iroha && \
    echo "export IROHA_HOME=${IROHA_HOME}" >>/usr/local/iroha/.bashrc && \
    echo "export JAVA_HOME=${JAVA_HOME}" >>/usr/local/iroha/.bashrc

RUN apt update && apt -y upgrade && apt -y install default-jdk

ADD ./iroha.tar /

RUN echo /usr/local/lib >>/etc/ld.so.conf && \
    echo /usr/local/iroha/lib >>/etc/ld.so.conf && \
    ldconfig

WORKDIR /usr/local/iroha

CMD ["/bin/su","-","iroha","-c","env IROHA_HOME=/usr/local/iroha /usr/local/iroha/bin/iroha-main"]
