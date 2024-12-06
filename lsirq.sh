#!/bin/bash

plik=/proc/interrupts
cmd=cat

if [ "$1" == -s ]
then
   cmd="sort -k 1 -r -n "
   shift
fi

if [ "$1" == -f ]
then
   plik=$2
   shift 2
fi

ncpu=$(head -n 1 $plik | wc -w )

while read -a linia
do
   if [[ ${linia[0]} =~ ^[0-9]+: ]]
   then
      nirq=0
      for((i=1;i<ncpu+1;i++))
      do
         let nirq=nirq+${linia[i]}
      done
      printf "%-10d %-8s %s\n" $nirq ${linia[0]%:} "${linia[*]:3+ncpu}"
   fi
done < $plik | $cmd

linia=( $(grep "LOC: " $plik) )

nirq=0
for((i=1;i<ncpu+1;i++))
do
   let nirq=nirq+${linia[i]}
done
printf "%-10d %s\n" $nirq "${linia[*]:1+ncpu}"

