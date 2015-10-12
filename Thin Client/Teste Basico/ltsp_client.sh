#!/bin/bash

n=4

arr=("firefox" "libreoffice --writer" "rhythmbox" "shotwelld"); 


start_time=`date -d "10/06/2015 22:54" +%s`
end_time=`date -d "10/06/2015 22:54" +%s`


sleep $(expr $start_time - `date +%s`) #start time to script

while [ true ]; do
	run=${arr[$(shuf -i 0-$n -n 1)]}
	sleep $(shuf -i 1-10 -n 1) 
	$run 
	sleep $(shuf -i 5-15 -n 1)
	if [ -z ${arr[$(shuf -i 0-`expr $n + 1` -n 1)]} ]; then 
		kill $(pidof ${arr[$(shuf -i 0-$n -n 1)]})
	fi
	if [ date +%s -ge $end_time ]; then
		break;
	fi
done


