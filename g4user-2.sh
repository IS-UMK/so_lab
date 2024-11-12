#!/bin/bash

if [ $# -eq 0 ]
then
   echo "Uzycie: $(basename $0) user"
   exit 1
fi

if ! a=( $(id -G "$1"  2> /dev/null ) )
then
   echo "Blad: nieznany uzytkownik $1"
   exit 2
fi

b=( $(id -nG "$1" ) )

i=0
while (( i < ${#a[*]} ))
do
   echo ${a[i]} ${b[i]}
   let i++
done


