#!/bin/bash


signal=2

echo "Set trap for signal $signal $(kill -L $signal)"

trap "echo Recieved signal $signal $(kill -L $signal)"  $signal

while true
do
    sleep 1
   #echo "Dzialam"
done
