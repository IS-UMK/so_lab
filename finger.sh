#!/bin/bash

[ "$1" ] || { echo "Uzycie: $(basename $0) regex"; exit 1; }

IFS=:
while read  user x uid gid name home shell
do
   if [[ ${user} =~ $1 ]] 
   then 
      echo "User: ${user}"
      echo "Name: ${name}"
      echo "Home: ${home}"
      echo "Shell: ${shell}"
      lastlog=$(lastlog -u ${user} | tail -n 1 | cut -d ' ' -f 2-)
      echo "Last login: ${lastlog}"
      if [ -r /home/${user}/.plan ]
      then
         cat "/home/${user}/.plan"
      else
         echo "No Plan."
      fi
      echo
   fi
done < /etc/passwd
