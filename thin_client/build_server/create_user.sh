
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" #1>&2
else
	# cd /etc/skel test_file

	for i in `seq 1 30`;
    do
	useradd user$i -p `echo $i | mkpasswd -s -H md5`
    done  
fi
