#!/bin/bash

echo "Host: $(hostname -f) ($(hostname -i))"
echo "Nazwa dystrybucji i numer wydania: $(grep PRETTY_NAME= /etc/os-release | cut -d = -f 2 | tr -d \")"
echo
echo
echo
echo
linia=$(grep ^MemTotal: /proc/meminfo )
linia=${linia#*:}
pam=${linia% *}
pamgb=$(echo "scale=4; $pam/2^20" | bc )
echo "Pamiec RAM w KiB (GiB): ${pam} (${pamgb})"
echo
