#!/bin/bash

file='memory'

if [ -a $file ]; then
	rm $file
fi 

(echo $BASHPID)>exec.wa

while (free -kt | grep Mem | awk '{print expr ($3 - ($6 + $7))}')>>$file; do 
    sleep 1
done
