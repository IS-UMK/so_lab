#!/bin/bash

if [ $# -eq 0 ]
then
   echo "brak argumentu"
   exit 2
fi

if ! printenv "$1" > /dev/null
then
   echo "nieznana zmienna"
   exit 1
else
   echo "$1=$(printenv $1)"
fi

exit 0


