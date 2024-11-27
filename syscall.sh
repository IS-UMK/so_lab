#!/bin/bash

plik=$( find /usr/include/ -name unistd_64.h )

regex=".*"

cmd=cat

if [ "$1" == -n ]
then
   cmd=sort
   shift
fi

[ "$1" ] && regex="$1"

sed -n 's/^#define __NR_//p' $plik | sed -E -n "/$regex/p" | $cmd

