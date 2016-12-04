#!/bin/bash

#-----------------------------------------------------------------------
# iroha_build - IROHA building scripts (Build IROHA)
#
# Copyright (c) 2016 Soramitsu,Co.,Ltd.
# All Rights Reserved.
#-----------------------------------------------------------------------

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

export IROHA_HOME=~/iroha
export IROHA_DEST=/usr/local/iroha

cd ~
git clone https://github.com/hyperledger/iroha.git

cd ${IROHA_HOME}

git clone https://github.com/nlohmann/json.git core/vendor/json
git clone https://github.com/gvanas/KeccakCodePackage.git core/vendor/KeccakCodePackage
git clone https://github.com/google/leveldb.git core/vendor/leveldb
git clone https://github.com/MizukiSonoko/ed25519.git core/vendor/ed25519
git clone --recursive https://github.com/MizukiSonoko/Cappuccino.git core/vendor/Cappuccino

apt -y install autoconf automake libtool pkg-config

cd /tmp
git clone -b v3.0.0 https://github.com/google/protobuf.git

cd protobuf
git cherry-pick 1760feb621a913189b90fe8595fffb74bce84598
./autogen.sh
./configure --prefix=/usr
make -j 14
make install

cd /tmp
git clone -b $(curl -L http://grpc.io/release) https://github.com/grpc/grpc

cd grpc
git submodule update --init
make
make install

cd ${IROHA_HOME}/core/vendor/leveldb
make

cd ${IROHA_HOME}/core/vendor/ed25519
make

cd ${IROHA_HOME}/core/vendor/KeccakCodePackage
make && make generic64/libkeccak.a

cd ${IROHA_HOME}/core/infra/crypto
make

mkdir ${IROHA_HOME}/build
cd ${IROHA_HOME}/build
cmake ..
make

sudo mkdir ${IROHA_DEST}
cd ${IROHA_HOME}
sudo rsync -av config core/vendor/Aeron/aeron-driver/build/libs ${IROHA_DEST}

cd build
sudo rsync -av bin lib my_test_bin test_bin ${IROHA_DEST}

if [ -f /usr/local/bin/start_iroha.sh ]; then
  sudo mv /usr/local/bin/start_iroha.sh ${IROHA_DEST}
else
  sudo rsync -av ./start_iroha.sh ${IROHA_DEST}
fi

if [ -f /usr/local/bin/test.sh ]; then
  sudo mv /usr/local/bin/test.sh ${IROHA_DEST}
else
  sudo rsync -av ./test.sh ${IROHA_DEST}
fi

sudo chown iroha:iroha ${IROHA_DEST}/start_iroha.sh ${IROHA_DEST}/test.sh
sudo chmod 0755 ${IROHA_DEST}/test.sh

exit 0
