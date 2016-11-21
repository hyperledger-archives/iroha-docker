#!/bin/bash

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export IROHA_HOME=/opt/iroha

su - iroha -c "java -cp ${IROHA_HOME}/core/vendor/Aeron/aeron-driver/build/libs/aeron-driver-1.0.5-SNAPSHOT-all.jar io.aeron.driver.MediaDriver &"

exec /bin/bash
