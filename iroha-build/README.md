# IROHA Building HowTo

[IROHA](http://iroha.tech/) is a simple Distributed Ledger Technology software.

IROHA will building  easily by using below shell scripts.

1. iroha_prep.sh
1. iroha_build.sh

## 1. iroha_prep.sh

This shell run by root user on Ubuntu 16.04.

``` bash
bash iroha_prep.sh
```

After execution of `iroha_prep.sh` script, _iroha_ user account was created and several development tools were installed on your environment.

## 2. iroha_build.sh

This shell run by _iroha_ user which created by `iroha_prep.sh` scripts.

<div>
<table><tr><td><b>Note</b>: iroha_build.sh script must run by <b>iroha</b> user. </td></tr></table>
</div>

``` bash
bash iroha_build.sh
```

This shell will be done below functions.

1. Cloning _IROHA_ from Hyperledger Project Official repositories on [github](https://github.com/hyperledger/iroha) .
1. Bulding IROHA libraries.
1. Building IROHA.
1.  Make IROHA directory on `/usr/local` as `/usr/local/iroha`.
1. Copy IROHA binaries, libraries and configuration files to IROHA directory.

## 3. Testing IROHA

You can test IROHA environment as follows.

At first you should restart java Aeron driver.

``` bash
ps -ef | grep java
kill <pid of java>

cd /usr/local/iroha
bash start_iroha.sh
```

You can test IROHA functions using by `test.sh` script on `/usr/local/iroha` directory.

``` bash
cd /usr/local/iroha
./test.sh
```

After IROHA build successfully, you can see `[ PASSED ] 5 tests.` message on the last line of `test.sh` window.

Have fun!

# Author
[Takeshi Yonezu](https://github.com/tkyonezu)

Copyrights (c) 2016, Soramitsu Co., Ltd.
All Rights Reserved.
