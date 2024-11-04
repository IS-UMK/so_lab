#!/bin/bash

echo "Host: $(hostname -f) ($(hostname -i))"
echo
echo
echo
echo
echo
tab=( $(grep MemTotal: /proc/meminfo) )
pamiec=${tab[1]}
pamiecGB=$( echo "scale=4; ${tab[1]} / 2^20" | bc)
echo "Pamiec RAM w KiB (GiB): ${pamiec} (${pamiecGB})"


