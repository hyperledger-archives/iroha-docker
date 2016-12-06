# IROHA Building HowTo

[IROHA](http://iroha.tech/) is a simple Distributed Ledger Technology software.

IROHA will building  easily by using below shell scripts.

1. iroha_prep.sh
1. iroha_build.sh

## 1. iroha_prep.sh

[iroha_prep.sh](iroha_prep.sh) run by _root_ user on Ubuntu 16.04.

``` bash
bash iroha_prep.sh
```

After execution of this script, _iroha_ user account was created and several development tools will be installed on your environment.

## 2. iroha_build.sh

[iroha_build.sh](iroha_build.sh) run by _iroha_ user which created by `iroha_prep.sh` scripts.

<div>
<table><tr><td><b>Note</b>: iroha_build.sh script must run by <b>iroha</b> user. </td></tr></table>
</div>

``` bash
su - iroha
bash iroha_build.sh
```

This script using several `sudo` commands, so you should enter IROHA's password.

```
[sudo] password for iroha: 
```

`iroha_prep.sh` has been created IROHA's password as `passw0rd`, so you should type this at above prompt.
 
This shell will be done below functions.

1. Cloning _IROHA_ from Hyperledger Project Official repositories on [github](https://github.com/hyperledger/iroha) .
1. Bulding IROHA libraries.
1. Building IROHA.
1.  Make IROHA directory on `/usr/local` as `/usr/local/iroha`.
1. Copy IROHA binaries, libraries and configuration files to IROHA directory.

After `iroha_build.sh` script execution, you can use IROHA on your `/usr/local/iroha` directories.

## 3. Docker container

If you want to use `iroha_build` repository on your docker container, you can use as below.

### 3.1 Build Docker

At first you wil build container as below.

``` bash
docker build -t hyperledger/iroha-build .
```

Then you can run `iroha-build` container as below.

``` bash
docker run -it --name iroha-build hyperledger/iroha-build /bin/bash
```

### 3.2 Build IROHA

After that, you can build IROHA in `iroha-build` container as below.

``` bash
cd /usr/local/iroha
bash iroha_prep.sh
su - iroha
cd /usr/local/iroha
bash iroha_build.sh
```

### 3.3 Commit Container

Now, you can commit this container, as below.

``` bash
docker commit <container id> hyperledger/iroha-build
```

### 3.4 Running Container

Then, you can run this container like this.

``` bash
HOME=$(pwd)
docker run -d --name iroha-build \
  -v ${HOME}/../iroha/config1:/usr/local/iroha/config \
  hyperledger/iroha-build /bin/su - iroha -c "env IROHA_HOME=/usr/local/iroha /usr/local/iroha/bin/iroha-main"
```

In this example, we are using sample configuration file which provided by `iroha` in the [iroha-docker](https://github.com/hyperledger/iroha-docker/) repository.

### 3.5 Running Containers by Script 

You can run `iroha-build` containers using by [run-iroha-build.sh](run-iroha-buiild.sh) script.

``` bash
./run-iroha-build.sh
```

This script runs four containers on your host machine.

### 3.6 Show Logs

You can show logs of the container, as below.

``` bash
docker logs -f iroha-build
```

Or

``` bash
docker logs -f iroha1 # iroha1 ... iroha4
```

Have fun!

# Author
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
