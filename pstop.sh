#!/bin/bash


LC_ALL=C

s=false
u=false

plik=""

cmd="sort -k 3 -n -r"

while getopts ":f:sumcn" opt
do
   case $opt in
      f) plik=$(< $OPTARG);;
      s) s=true ;; 
      u) u=true ;;
      m) cmd="sort -n -k 4 -r" ;;
      c) cmd="sort -n -k 2 -r" ;;
      n) cmd="sort -k 1" ;;
      *) echo "Blad" ;;
   esac
done
shift $((OPTIND-1))

# echo "s=$s u=$u m=$m c=$c n=$n plik=$plik"

if [ -z "$plik" ]
then
   plik=$(ps -eo user,uid,pmem,pcpu,comm)
fi
plik=$(sed 1d <<< "${plik}")

declare -A liczba
declare -A pcpu
declare -A pmem

while read user uid mem cpu comm
do
   if $s && [ $uid -ge 1000 ]
   then
      continue
   fi
   if $u && [ $uid -lt 1000 ]
   then
      continue
   fi
   let liczba[$user]++
   pcpu[$user]=$(echo "$cpu + ${pcpu[$user]-0.0}" | bc -l )
   pmem[$user]=$(echo "$mem + ${pmem[$user]-0.0}" | bc -l )
done  <<< "${plik}"

for user in ${!liczba[*]}
do 
   printf "%-15s %5d %5.1f %5.1f\n"  $user ${liczba[$user]} ${pcpu[$user]} ${pmem[$user]}
done | $cmd






