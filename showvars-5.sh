#!/bin/bash

if [ "$1" == -n ]
then
   printenv | wc -l
   exit 0
fi

for arg
do
   echo $arg
done


