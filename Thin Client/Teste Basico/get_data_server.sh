#!/bin/bash

file='memory'
cpu='cpu'
head="processo   memoria  RX    TX   "





(cat <(grep 'cpu ' /proc/stat) <(sleep 1 && grep 'cpu ' /proc/stat) | awk -v RS="" '{print ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)}')>>cpu


# while (free -mt | grep Mem | awk '{print $3}')>>file; do i=0; done &  #verifica a memoria


# while (cat <(grep 'cpu ' /proc/stat) <(sleep 1 && grep 'cpu ' /proc/stat) | awk -v RS="" '{print ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)}')>>cpu; do i=0; done &  #verifica a memoria


arr=("firefox" "libreoffice --writer" "rhythmbox" "shotwelld"); 


sleep $(expr `date -d "10/06/2015 22:54" +%s` - `date +%s`) #start time to script

for run in "${arr[@]}"
do

	start_RX=$(ifconfig eth0 | grep 'bytes'| awk -F "(:|\()" '{print $2}') #get RX initial
	start_TX=$(ifconfig eth0 | grep 'bytes'| awk -F "(:|\()" '{print $4}') #get TX initial
	rm file #reset data of memory
	start_memory=$(free -mt | grep Mem | awk '{print $3}') #get memory initial
	start_time=$(date "+%s") #time
	$run
	read input # flag 
	end_time=$(date "+%s") #time
	(cat file)>result 
	end_RX=$(ifconfig eth0 | grep 'bytes'| awk -F "(:|\()" '{print $2}') #transfer net
	end_TX=$(ifconfig eth0 | grep 'bytes'| awk -F "(:|\()" '{print $4}') #transfer net


	#solution data (memory)
	ar=$(cat result)
	IFS=$'\n'
	bigger=("${ar[*]}" | sort -nr | head -n1)
	memory=`expr $bigger - $start_memory`

	#solution data (net)
	net_RX=`expr $end_RX - $start_RX`
	net_TX=`expr $end_TX - $start_TX`

	#solution data (time)
	time_run=`expr $end_time - $start_time`
done



#!/bin/bash
n=4

arr=("firefox" "libreoffice --writer" "rhythmbox" "shotwelld"); 


while (free -mt | grep Mem | awk '{print $3}')>>file; do i=0; done &  #verifica a memoria


while (cat <(grep 'cpu ' /proc/stat) <(sleep 1 && grep 'cpu ' /proc/stat) | awk -v RS="" '{print ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)}')>>cpu; do i=0; done &  #verifica a memoria



start_time=`date -d "10/06/2015 22:54" +%s`
end_time=`date -d "10/06/2015 22:54" +%s`


sleep $(expr $start_time - `date +%s`) #start time to script


start_RX=$(ifconfig eth0 | grep 'bytes'| awk -F "(:|\()" '{print $2}') #get RX initial
start_TX=$(ifconfig eth0 | grep 'bytes'| awk -F "(:|\()" '{print $4}') #get TX initial
start_memory=$(free -mt | grep Mem | awk '{print $3}') #get memory initial
start_cpu=$(cat <(grep 'cpu ' /proc/stat) <(sleep 1 && grep 'cpu ' /proc/stat) | awk -v RS="" '{print ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)}')
while [ true ]; do
	if [ date +%s -ge $end_time ]; then
		break;
	fi
done
(cat file)>result 
end_RX=$(ifconfig eth0 | grep 'bytes'| awk -F "(:|\()" '{print $2}') #transfer net
end_TX=$(ifconfig eth0 | grep 'bytes'| awk -F "(:|\()" '{print $4}') #transfer net


#solution data (net)
net_RX=`expr $end_RX - $start_RX`
net_TX=`expr $end_TX - $start_TX`

#solution data (memory)
ar=$(cat result)
IFS=$'\n'
bigger=("${ar[*]}" | sort -nr | head -n1)
memory_middle=`expr $bigger - $start_memory`

#solution data (CPU)
ar=$(cat cpu)
IFS=$'\n'
bigger_cpu=("${ar[*]}" | sort -nr | head -n1)
