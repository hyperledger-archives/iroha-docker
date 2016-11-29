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
docker build -t soramitsu/iroha-dev .
```

## 2. iroha

This container based on iroha-dev image and include IROHA repository to make binaries for IROHA.

``` bash
docker build -t soramitsu/iroha .
```

You can run this container as below.

``` bash
docker run -it --name iroha --shm-size 512m soramitsu/iroha /bin/bash
```

For testing it will better for you to use bash command.

And also you can make IROHA tar ball by mounting host filesystem on this container.

``` bash
docker run -it --name iroha --shm-size 512m -v /var/tmp:/var/tmp soramitsu/iroha /bin/bash
```

After iroha container started, you can make iroha tarball as below.

``` bash
cd /
tar cvf /var/tmp/iroha.tar usr/local/iroha
``` 

Then you can get `iroha.tar` file on your host directory `/var/tmp`.

## 3. iroha-rel

This container based on Ubuntu 16.04 and include IROHA binaries, libraries and configuration files from `iroha.tar` file which made by iroha container.

``` bash
docker build -t soramitsu/iroha-rel .
```

You can run this container as below.

``` bash
docker run -it --name iroha-rel --shm-size 512m soramitsu/iroha-rel /bin/bash
```

## 4. IROHA configuration

When you running IROHA,  you should configure `sumeragi.json` file in the `/usr/local/iroha/config` deirectory. Below is the simplest example of `sumeragi.conf` file for three instances.

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
      "publicKey":"jDQTiJ1dnTSdGH+yuOaPPZIepUj1Xt3hYOvLQTME3V0="
    },
    {
      "ip":"172.17.0.4",
      "name":"iroha3",
      "publicKey":"jDQTiJ1dnTSdGH+yuOaPPZIepUj1Xt3hYOvLQTME3V0="
    }
  ]
}
```
Off coure you should change ip address, publicKey, and privateKey for your real environment.

When you testing IROHA, you can use `sumeragi_test` command in the `/usr/local/iroha/my_test` directory. 

## 5. IROHA test

You can test your IROHA like this in the case of three instances.

First instance will be run below docker command.

``` bash
docker run -it --name iroha1 --shm-size 512m -v ${HOST_DIR1}/sumeragi.json:/usr/local/iroha/config soramitsu/iroha-rel /bin/bash
```
_HOST_DIR1_ environment variable is a host directory for `sumeragi.json` of 1st instance.

Second instance will be run as below.

``` bash
docker run -it --name iroha2 --shm-size 512m -v ${HOST_DIR2}/sumeragi.json:/usr/local/iroha/config soramitsu/iroha-rel /bin/bash
```

Third instance will be run as below.

``` bash
docker run -it --name iroha3 --shm-size 512m -v ${HOST_DIR3}/sumeragi.json:/usr/local/iroha/config soramitsu/iroha-rel /bin/bash
```
Then you can run `sumeragi_test` in these three instances as below.

``` bash
bash start_iroha.sh
```

You can see _aeron_driver is running like this.

```
root@417e46fd8439:/usr/local/iroha# ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 12:38 ?        00:00:00 /bin/bash
root        10     1  0 12:39 ?        00:00:00 /bin/bash
iroha       13     1 12 12:39 ?        00:00:02 java -cp /usr/local/iroha/libs/a
```

Then you can use `sumeragi_test` command.

``` bash
su - iroha
cd my_test_bin
./sumeragi_test
```

Last instance will be need _public_ argument for `sumeragi_test` command.

``` bash
./sumeragi_test public
```

Have fun!

## Authors
[Takeshi Yonezu](https://github.com/tkyonezu)

Copyright (c) 2016 Soramitsu Co., Ltd.
