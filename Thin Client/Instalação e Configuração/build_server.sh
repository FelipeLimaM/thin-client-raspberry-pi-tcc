#!/bin/bash

# author Felipe Lima Morais - Graduando de Ciência da Computação
CHOICE_INTERFACE_DIR=/etc/default/isc-dhcp-server
CONF_INTERFACE_DIR=/etc/network/interfaces

NEW_CONF=ConfInterface
NEW_CONF_BAK=ConfInterface.backup

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" #1>&2
else
    INSTALL_PACKAGE=ltsp-server-standalone
    
    clear
    echo " update packages"
    sleep 1
    sudo apt-get install update

    clear
    echo " upgrade of packages"
    sleep 1
    sudo apt-get upgrade -y 

    clear
    echo " download/install package ltsp-server-standalone install"
    sleep 2
    sudo apt-get install $INSTALL_PACKAGE -y

	sudo apt-get install gnome-session-fallback -y
	sudo/usr/lib/lightdm/lightdm-set-defaults -s gnome-fallback


    if ((1<<32)); then
        echo your 64bits system
        ltsp-build-client --arch="i386" 
    else
        echo you 32bits system
        ltsp-build-client
    fi
	clear
	# ALTER  /etc/default/isc-dhcp-server
	connect=$(ifconfig |  grep -E encap | awk -F 'Link' '{print $1 }'   | awk -F '$' '{print $1 }')
	select result in $connect
	do
		if [ -n "$result" ]; then	
			
			INTERFACE=$result
			sed -i 's/INTERFACES\=.*/INTERFACES\=\"'$result'\"/g' $CHOICE_INTERFACE_DIR	
			break
		fi
	done

	# BACKUP / ALTER  /etc/network/interfaces
	
	(cat $NEW_CONF) > $NEW_CONF_BAK

	sed -i 's/???/'$result'/g' $NEW_CONF

	(cat $NEW_CONF) >> $CONF_INTERFACE_DIR

	(cat $NEW_CONF_BAK) > $NEW_CONF

	rm $NEW_CONF_BAK

	sudo reboot	
	


fi