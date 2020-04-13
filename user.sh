#!/bin/bash
#v0.1.0

# Ethernet
systemctl enable dhcpd
systemctl start dhcpd
echo "Ignore ^ if you use wifi"
echo
 
# Check for internet connection
echo "---- ---- ---- ---- ----"
echo
ping www.google.com -c 1
echo
echo "---- ---- ---- ---- ----"
echo "Are you connected to the internet? (y/n)"
read net
if [ $net = y ] || [ $net = Y ]
then
	echo "Nice, lets continue..."
else
	echo
	echo "!! You need an internet connection to use this script !!"
	exit 1
fi
echo

# Add an user
echo "Choose your username:"
read usr
echo "Is Username -$usr- correct? (y/n)"
read check
if [ $check = y ] || [ $check = Y ]
then
	useradd -m -g users -G wheel $usr
	passwd $usr
else
	echo
	echo "!! Failed to create a user !!"
	exit 1
fi
echo

# Sudo setup
echo "Do you want to enable sudo? (y/n)"
read sudo
if [ $sudo = y ] || [ $sudo = Y ]
then
	pacman -S sudo
	echo "Uncoment the -#- where you see, -%wheel ALL=(ALL) ALL- to add sudo privileges to your user."
	echo "continue (y/n)"
else
	echo "Sudo not activated for this user"
fi
echo "If you skipped sudo, answer: n"
read wheel
if [ $wheel = y ] || [ $wheel = Y ]
then
	EDITOR=nano visudo
else
	echo "Done!"
fi
echo

echo "Now login as your new user!"
echo "Type exit to logout from root."
