#!/bin/bash

function create_zombie
{
   sleep 1 &
   echo "child PID $!"
   wait 
}

create_zombie &
pid=$!

echo "create_zombie PID $!"

sleep 0.1
kill -n 19 $pid

sleep 1.5
ps -o pid,s,comm

while true
do
   sleep 1 
done
