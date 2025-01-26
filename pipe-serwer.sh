#!/bin/bash

plik=/tmp/server-$$
mkfifo $plik

echo "serwer: utworzylem $plik"

trap "rm $plik" EXIT

function worker
{
   echo "Worker dziala"
   while true
   do
      read komenda < $1 
      echo "worker: komenda=$komenida"
      wynik=$(eval "$komenda"  2>/dev/null ) 
      if [ $? -eq 0 ]
      then
         echo "worker: wysylam wynik"
         echo "$wynik" > "$1"
      else
         echo "worker: blad"
         echo "error: unknown command" > "$1"
      fi
   done
}

while true
do
   read komunikat < $plik
   echo "serwer: komunikat=$komunikat"
   if [ -p $komunikat ]
   then
      worker "$komunikat" &
   fi
done
