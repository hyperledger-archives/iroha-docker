#-----------------------------------------------------------------------
# iroha-rel - IROHA container for Release
#
# build : docker build -t soramitsu/iroha-rel .
#
# Copyright (c) 2016 Soramitsu,Co.,Ltd.
# All Rights Reserved.
#-----------------------------------------------------------------------
FROM ubuntu

MAINTAINER Takeshi Yonezu <yonezu@soramitsu.co.jp>

LABEL BUILD="docker build -t soramitsu/iroha-rel ."
LABEL RUN="docker run -it --name iroha --sm-size 512m soramitsu/iroha-rel /bin/bash"

USER root

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV IROHA_HOME=/usr/local/iroha

RUN groupadd -g 168 iroha && \
    useradd -u 168 -c "IROHA Administrator" -s /bin/bash -m -d /usr/local/iroha -p $(perl -e "print(crypt('passw0rd', 'sa'));") -g iroha iroha && \
    usermod -G adm,sudo iroha && \
    echo "export IROHA_HOME=${IROHA_HOME}" >>/usr/local/iroha/.bashrc && \
    echo "export JAVA_HOME=${JAVA_HOME}" >>/usr/local/iroha/.bashrc

RUN apt update && apt -y upgrade
RUN apt -y install default-jdk

ADD ./iroha.tar /

WORKDIR /usr/local/iroha

CMD ["/bin/bash","/usr/local/iroha/start_iroha.sh"]
