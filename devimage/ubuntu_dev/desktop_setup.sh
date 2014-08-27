#!/bin/bash

# Set up desktop for Ubuntu Development System
# General Forensics
# 2014-08-18
#
# Usage:
#    bash desktop_setup.sh
#
# Run from user's home directory

# Install desktop
sudo apt-get -y install lubuntu-desktop
# Turn off guest login
sudo sh -c 'printf "[SeatDefaults]\nallow-guest=false\n" >/usr/share/lightdm/lightdm.conf.d/50-no-guest.conf'

# Get remote desktop servers
sudo apt-get -y install tightvncserver xrdp
cat "lxsession -s Lubuntu -e LXDE" > .xsession

# Install the VBoxGuestAdditions.iso
mkdir /media/VBoxGuestAdditions
mount -o loop,ro VBoxGuestAdditions.iso /media/VBoxGuestAdditions
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
# rm VBoxGuestAdditions.iso
umount /media/VBoxGuestAdditions
rmdir /media/VBoxGuestAdditions

### Install dev applications
# MySQL Workbench
if [ ! -e /usr/bin/mysql-workbench ]
then
	WORKBENCH_FILE=mysql-workbench-community-6.1.7-1ubu1404-amd64.deb
	if [ ! -e ${WORKBENCH_FILE} ]
	then
		wget http://dev.mysql.com/get/Downloads/MySQLGUITools/${WORKBENCH_FILE}
	fi
	sudo dpkg -i ${WORKBENCH_FILE}
	# Fix dependencies (MySQL default version is 5.5, we installed 5.6)
	sudo apt-get -y -f install
	rm ${WORKBENCH_FILE}
fi

# NetBeans 8.0
NB_FILE=netbeans-8.0-linux.sh
if [ ! -e /usr/local/netbeans-8.0 ]
then
	wget http://dlc.sun.com.edgesuite.net/netbeans/8.0/final/bundles/${NB_FILE}
	sudo sh ${NB_FILE} --silent
	rm ${NB_FILE}
fi

# Eclipse Luna
if [ ! -e eclipse ]
then
	ECLIPSE_FILE=eclipse-jee-luna-R-linux-gtk-x86_64.tar.gz
	if [ ! -e ${ECLIPSE_FILE} ]
	then
		wget http://developer.eclipsesource.com/technology/epp/luna/${ECLIPSE_FILE}
	fi
	# Installs for local user
	tar zxvf ${ECLIPSE_FILE}
	cd eclipse
	# Install PDT plugin
	./eclipse -application org.eclipse.equinox.p2.director -noSplash -repository http://download.eclipse.org/tools/pdt/updates/3.3/,http://download.eclipse.org/releases/luna/ -installIUs org.eclipse.php.feature.group
	cd ..
	rm ${ECLIPSE_FILE}
fi
