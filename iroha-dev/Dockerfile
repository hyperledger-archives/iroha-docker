#-----------------------------------------------------------------------
# iroha-dev - IROHA development container (base image for iroha)
#
# build : docker build -t hyperledger/iroha-dev .
#
# Copyright (c) 2016 Soramitsu,Co.,Ltd.
# All Rights Reserved.
#-----------------------------------------------------------------------
FROM ubuntu

MAINTAINER Takeshi Yonezu <yonezu@soramitsu.co.jp>

LABEL BUILD="docker build -t hyperledger/iroha-dev ."

USER root

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV IROHA_HOME=/opt/iroha

RUN groupadd -g 168 iroha && \
    useradd -u 168 -c "IROHA Administrator" -s /bin/bash -m -p $(perl -e "print(crypt('passw0rd', 'sa'));") -g iroha iroha && \
    usermod -G adm,sudo iroha && \
    echo "export IROHA_HOME=${IROHA_HOME}" >>/home/iroha/.bashrc && \
    echo "export JAVA_HOME=${JAVA_HOME}" >>/home/iroha/.bashrc && \
    echo "export IROHA_HOME=${IROHA_HOME}" >>/root/.bashrc && \
    echo "export JAVA_HOME=${JAVA_HOME}" >>/root/.bashrc

RUN apt update && apt -y upgrade

RUN apt -y install software-properties-common python-software-properties && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test

RUN apt -y install curl git make g++-5 gcc-5 default-jdk && \
    apt -y install libhdf5-serial-dev libleveldb-dev libsnappy-dev && \
    apt -y install liblmdb-dev libssl-dev snappy unzip xsltproc zlib1g-dev && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 20 && \
    update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++-5 20 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 20 && \
    update-alternatives --install /usr/bin/cc cc /usr/bin/gcc-5 20

RUN curl -sSL https://cmake.org/files/v3.5/cmake-3.5.2-Linux-x86_64.tar.gz | tar -xzC /opt && \
    ln -s /opt/cmake*/bin/c* /usr/local/bin

CMD ["/bin/bash"]
