#!/bin/bash

plik=""
s=false 
u=false
cmd="sort -k 3 -n "

LC_ALL=C

while getopts ":sumncf:" opt
do
   case $opt in
      s) s=true ;; 
      u) u=true ;;
      m) m=true ;;
      n) n=true ;;
      c) c=true ;;
      f) plik=$( < $OPTARG ) ;; 
      *) echo "Nieznana opcja $OPTARG"
   esac
done
shift $((OPTIND-1))

# echo "s=$s u=$u m=$m n=$n c=$c plik=$plik"

if [ -z "$plik" ]
then
   plik=$(ps -eo user,uid,pmem,pcpu,comm)
fi

plik=$(sed 1d <<< "${plik}")

declare -A count
declare -A mem
declare -A cpu

while read user uid pmem pcpu comm
do
   if $u && [ $uid -lt 1000 ] 
   then
      continue
   fi
   if $s && [ $uid -ge 1000 ] 
   then
      continue
   fi

   let count[$user]++
   mem[$user]=$( echo "${mem[$user]-0.0}+ $pmem" | bc -l )
   cpu[$user]=$( echo "${cpu[$user]-0.0}+ $pcpu" | bc -l )
done <<< "${plik}"

for user in ${!count[*]}
do
   echo $user ${count[$user]} ${mem[$user]} ${cpu[$user]}
done | $cmd


