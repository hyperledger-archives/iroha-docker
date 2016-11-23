#!/bin/bash

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export IROHA_HOME=/usr/local/iroha

su - iroha -c "java -cp ${IROHA_HOME}/libs/aeron-driver-1.0.5-SNAPSHOT-all.jar io.aeron.driver.MediaDriver &"

echo ">>> You can execute IROHA by iroha user."
echo ">>> So, you should type \"su - iroha\" at first."
echo ">>> Have a fantastic IROHA world!."

exec /bin/bash
