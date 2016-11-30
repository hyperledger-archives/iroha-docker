#!/bin/bash

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export IROHA_HOME=/usr/local/iroha

## su - iroha -c "java -cp ${IROHA_HOME}/libs/aeron-driver-1.0.5-SNAPSHOT-all.jar io.aeron.driver.MediaDriver &"

exec /bin/bash
