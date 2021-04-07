#!/usr/bin/env sh
echo 'Generating 32-character passwords'
for ((n=0;n<100;n++))
do dd if=/dev/urandom count=1 2> /dev/null | uuencode -m - | sed -ne 2p | cut -c-128
done