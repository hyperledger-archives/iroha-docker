#!/bin/bash


if tty | grep -q pts 2>&1 >/dev/null; then
  # For Ubuntu
  TTY="/dev/pts/"
  n=0
else
  # For MacOS
  TTY="/dev/ttys00"
  n=1
fi

if [ $# -gt 0 ]; then
  n="$1"
fi

for i in 1 2 3 4; do
  docker logs -f iroha$i >${TTY}${n} &

  ((n+=1))
done

exit 0
