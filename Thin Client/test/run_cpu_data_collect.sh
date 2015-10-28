#!/bin/bash

file='cpu'

if [ -a $file ]; then rm $file; fi

(echo $BASHPID)>exec.wa

while (cat <(grep 'cpu ' /proc/stat) <(sleep 1 && grep 'cpu ' /proc/stat) | awk -v RS="" '{print ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)}')>>$file; do 
    i=0; 
done
