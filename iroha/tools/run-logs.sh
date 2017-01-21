#!/bin/bash

if [ $# -eq 0 ]; then
  NO=0
else
  NO=$1
fi

if tty | grep -q pts 2>&1 >/dev/null; then
  # For Ubuntu
  TTY="/dev/pts/"
  n=$((0 +$NO))
else
  # For MacOS
  TTY="/dev/ttys00"
  n=$((1 + $NO))
fi

for i in 1 2 3 4; do
  docker logs -f iroha$i >${TTY}${n} &

  ((n+=1))
done

exit 0
