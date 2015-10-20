#!/bin/bash

arr=("firefox" "libreoffice --writer" "rhythmbox" "libreoffice --calc" "/usr/games/gnome-sudoku" "libreoffice --draw" "libreoffice --calc" "/usr/games/sol"); 

temp=(3 5 2 6 1 0 4 3 2 8 4 1 4 5 1 6 3 1 6 7 3 1 5 2 5);

n=`expr ${#arr[@]} - 1`

start_time=`date -d "10/19/2015 23:50" +%s`
end_time=`date -d "10/19/2015 23:51" +%s`


sleep $(expr $start_time - `date +%s`) #start time to script

while [ true ]; do
	
	for i in `seq 0 $n`; do
		${arr[$i]} &
		sleep ${temp[$i]}
	done

	if [ $(date +%s) -ge $end_time ]; then
		break;
	fi
done
