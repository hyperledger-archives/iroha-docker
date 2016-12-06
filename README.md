# Dcokerfiles for IROHA

[IROHA](http://iroha.tech/) is a simple Distributed Ledger Technology software.

IROHA containers are consist of three containers, one is for development environment based on Ubuntu 16.04. Second container is iroha repository building container, which can run IROHA. Last container is production level container  which reduced image size by IROHA runtimes and configuration files only.

1. iroha-dev
1. iroha
1. iroha-rel

Also, [iroha-build](iroha-build/) contains building scripts for IROHA on your non dockernized environment.

## 1. iroha-dev

This container based on Ubuntu 16.04 and install development tools for IROHA.

``` bash
docker build -t hyperledger/iroha-dev .
```

## 2. iroha

This container based on iroha-dev image and include IROHA repository to make binaries for IROHA.

``` bash
docker build -t hyperledger/iroha .
```

You can run this container as below.

``` bash
docker run -d --name iroha hyperledger/iroha
```

For testing it will better for you to use bash command.

And also you can make IROHA tar ball by mounting host filesystem on this container.

``` bash
docker run -it --name iroha -v /var/tmp:/var/tmp hyperledger/iroha /bin/bash
```

After iroha container started, you can make iroha tarball as below.

``` bash
cd /
tar cvf /var/tmp/iroha.tar usr/lib/libproto* usr/local
``` 

You can use [mkiroha-tar.sh](iroha/mkiroha-tar.sh) scripts on `/usr/local/iroha` directory for your convenience.

Then you can get `iroha.tar` file on your host directory `/var/tmp`.

## 3. iroha-rel

This container based on Ubuntu 16.04 and include IROHA binaries, libraries and configuration files from `iroha.tar` file which made by iroha container.

``` bash
docker build -t hyperledger/iroha-rel .
```

You can run this container as below.

``` bash
docker run -d --name iroha-rel hyperledger/iroha-rel
```

## 4. IROHA configuration

When you running IROHA,  you should configure `sumeragi.json` file in the `/usr/local/iroha/config` deirectory. Below is simple example of [sumeragi.conf](iroha/config1/sumeragi.json) file for four instances.

``` json:sumeragi.json
{
  "me":{
    "ip":"172.17.0.2",
    "name":"iroha1",
    "publicKey":"jDQTiJ1dnTSdGH+yuOaPPZIepUj1Xt3hYOvLQTME3V0=",
    "privateKey":"iJy2wzgM0Ffmur2xDNlnhYK7CiAYZoup/045JXJTbUzuE9c6HeUIf7hoqtppEsZQncC1EEw+gGhboLcbMNKadw=="
  },
  "group":[
    {
      "ip":"172.17.0.2",
      "name":"iroha1",
      "publicKey":"jDQTiJ1dnTSdGH+yuOaPPZIepUj1Xt3hYOvLQTME3V0="
    },
    {
      "ip":"172.17.0.3",
      "name":"iroha2",
      "publicKey":"Q5PaQEBPQLALfzYmZyz9P4LmCNfgM5MdN1fOuesw3HY="
    },
    {
      "ip":"172.17.0.4",
      "name":"iroha3",
      "publicKey":"f5MWZUZK9Ga8XywDia68pH1HLY/Ts0TWBHsxiFDR0ig="
    },
    {
      "ip":"172.17.0.5",
      "name":"iroha4",
      "publicKey":"Sht5opDIxbyK+oNuEnXUs5rLbrvVgb2GjSPfqIYGFdU="
    }
  ]
}
```
Off course you should change ip address, publicKey, and privateKey for your real environment.

## 5. IROHA test

You can test your IROHA like this in the case of four instances.

### 5.1 Running IROHA

You can run IROHA containers using by [run-iroha.sh](iroha/run-iroha.sh) script.

``` bash
./run-iroha.sh
```

Four IROHA's container will be running as below.

```
# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
19fec9daa721        hyperledger/iroha   "/bin/su - iroha -c '"   3 seconds ago       Up 2 seconds                            iroha4
8fe12c100517        hyperledger/iroha   "/bin/su - iroha -c '"   4 seconds ago       Up 3 seconds                            iroha3
0852acdc74b8        hyperledger/iroha   "/bin/su - iroha -c '"   4 seconds ago       Up 3 seconds                            iroha2
70db7f427307        hyperledger/iroha   "/bin/su - iroha -c '"   5 seconds ago       Up 4 seconds  
```

### 5.2 IROHA logs

Then you can see IROHA container logs using by docker command.

``` bash
docker logs iroha1
```

or display logs forever mode as you like.

``` bash
docker logs -f iroha1
```

### 5.3 Testing IROHA

You can test IROHA simply by REST/API using by [run-curl.sh](iroha/run-curl.sh)  script. Below is an example of `run-curl.sh` execution.

```
# ./run-curl.sh 
POST    "172.17.0.2:1204" "/asset/operation"
REQUEST {"command":"add","domain":"iroha","name":"iroha2"}
REPLY   {"message":"OK","status":200}
```

Then you can run `sumeragi_test` for testing continuesly consensused by `sumeragi` on IROHA.

For example, you can run [run-sumeragi.sh](iroha/run-sumeragi.sh) script and you'll ty below commands as below.

```
# ./run-sumeragi.sh
# su - iroha
$ cd /usr/local/iroha/my_test_bin
$ ./sumeragi_test public 
```

`sumeragi_test` will be running as below.

```
$ ./sumeragi_test public
=========
jDQTiJ1dnTSdGH+yuOaPPZIepUj1Xt3hYOvLQTME3V0=
172.17.0.2
=========
Q5PaQEBPQLALfzYmZyz9P4LmCNfgM5MdN1fOuesw3HY=
172.17.0.3
=========
f5MWZUZK9Ga8XywDia68pH1HLY/Ts0TWBHsxiFDR0ig=
172.17.0.4
=========
Sht5opDIxbyK+oNuEnXUs5rLbrvVgb2GjSPfqIYGFdU=
172.17.0.5
1480987886[sumeragi] +==ーーーーーーーーー==+
1480987886[sumeragi] |+-ーーーーーーーーー-+|
1480987886[sumeragi] || 　　　　　　　　　 ||
1480987886[sumeragi] || いろは合意形成機構 ||
1480987886[sumeragi] || 　　　すめらぎ　　 ||
1480987886[sumeragi] || 　　　　　　　　　 ||
1480987886[sumeragi] |+-ーーーーーーーーー-+|
1480987886[sumeragi] +==ーーーーーーーーー==+
1480987886[sumeragi] - 起動/setup
1480987886[sumeragi] - 初期設定/initialize
```

You can show each container's log by `docker logs` command as you like.

``` bash
docker logs -f iroha1
```

Docker containers will be stopped by `docker stop` command.

``` bash
docker stop $(docker ps -q)
```

Have fun!

## Authors
[Takeshi Yonezu](https://github.com/tkyonezu)

## License

Copyright 2016 Soramitsu Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
