#!/bin/bash

file_memory='memory'
file_cpu='cpu'
 
start_time=`date -d "10/19/2015 23:50" +%s`
end_time=`date -d "10/19/2015 23:51" +%s`

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" #1>&2
else

	echo "wait.."

	bash collect_data_memory.sh & #start collection
	aux=$(cat exec.wa)
	pid_memory=`expr $aux - 2`
	echo "pid_memory $pid_memory"

	bash collect_data_cpu.sh & #start collection
	aux=$(cat exec.wa)
	pid_cpu=`expr $aux - 2`
	echo "pid_cpu $pid_cpu"

	sleep $(expr $start_time - `date +%s`) #start time to script
	echo "go go $(date)"

	start_RX=$(ifconfig eth0 | grep 'bytes'| awk -F "(:|\()" '{print $2}') #get RX initial
	start_TX=$(ifconfig eth0 | grep 'bytes'| awk -F "(:|\()" '{print $4}') #get TX initial
	start_memory=$(free -kt | grep Mem | awk '{print expr ($3 - ($6 + $7))}') #get memory initial
	start_cpu=$(cat <(grep 'cpu ' /proc/stat) <(sleep 1 && grep 'cpu ' /proc/stat) | awk -v RS="" '{print ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)}') #get cpu initial

	rm $file_memory
	rm $file_cpu

	while [ true ]; do
		echo "loop"
		sleep 1
		if [ $(date +%s) -ge $end_time ]; then
			break;
		fi
	done
	if [ -a test_cpu ]; then rm test_cpu; fi
	if [ -a test_memory ]; then rm test_memory; fi
	(cat $file_memory)>test_memory
	(cat $file_cpu)>test_cpu
	end_RX=$(ifconfig eth0 | grep 'bytes'| awk -F "(:|\()" '{print $2}') #transfer net
	end_TX=$(ifconfig eth0 | grep 'bytes'| awk -F "(:|\()" '{print $4}') #transfer net


	#solution data (net)
	net_RX=`expr $end_RX - $start_RX`
	net_TX=`expr $end_TX - $start_TX`

	#solution data (memory)
	memory_used=0
	$start_memory
	memory_used=(`python -c "print (max([float(line.rstrip('\n')) for line in open('test_memory')]) - float($start_memory))/1024"`)


	#solution data (CPU)
	cpu_used=0
	cpu_max=(`python -c "print max([float(line.rstrip('\n')) for line in open('test_cpu')])"`)

	date
	echo -e "memory used \t $memory_used"
	echo -e "trafic send \t $net_RX" 
	echo -e "trafic reciv \t $net_TX" 
	echo -e "cpu upper \t $cpu_max"


fi
