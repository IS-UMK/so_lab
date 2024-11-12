#!/bin/bash

eval $1 > /dev/null 2>1 
echo "Exit code is $?"
