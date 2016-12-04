#!/bin/bash

#-----------------------------------------------------------------------
# test - IROHA test scripts
#
# Copyright (c) 2016 Soramitsu,Co.,Ltd.
# All Rights Reserved.
#-----------------------------------------------------------------------

n=0

for file in test_bin/*; do
  ./${file}

  n=$((n + $?)) 
done

exit 0
