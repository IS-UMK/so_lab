#!/bin/bash

s=true
p=true

if [ "$1" == -s ]
then
   p=false
   shift
fi
if [ "$1" == -p ]
then
   s=false
   shift
fi

if [ $# -eq 0 ]
then
   echo "usage: $(basename $0) [-p|-s] <gid>"
   exit 1
fi

gid=$1

if [[ ! "$1" =~ ^[0-9]+$ ]]
then
   gid=$(awk -F: -v nazwa=$1 '$1 == nazwa { print $3 }'   /etc/group)
fi

pusers=$( awk -F : -v gid=$gid '$4 == gid {print $1}' /etc/passwd)
susers=$( awk -F : -v gid=$gid '$3 == gid {print $4}' /etc/group | sed 's/,/\n/g' )
# echo pusers=$pusers
# echo susers=$susers

users=""

$p && users="${pusers}"
$p && $s && users+="\n"
$s && users+="${susers}"

echo -e "${users}" | sort

