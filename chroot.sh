#!/bin/bash
#v0.1.3
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

# Locale
echo "Uncomment the # for your prefered locale and save"
echo "Continue (y/n)"
read locale
if [ $locale = y ] || [ $locale = Y ]
then
	pacman -S nano
	nano /etc/locale.gen
	locale-gen
else
	echo
	echo "!! Failed to setup locale !!"
	exit 1
fi
echo

# Hostname
echo "Whats your prefered hostname?"
read hostnm
echo "Your hostname is set to $hostnm"
echo "correct? (y/n)"
read host
if [ $host = y ] || [ $host = Y ]
then
	echo "127.0.0.1	localhost
::1		localhost
127.0.1.1	$hostnm.localdomain	$hostnm" > /etc/hosts
	echo
	echo $hostnm > /etc/hostname
else
	echo
	echo "!! Failed to setup hostname !!"
	exit 1
fi
echo

# Password
passwd

# Bootloader
echo "Do you want to install -grub- bootloader?"
echo "(y/n)"
read bootloader
if [ $bootloader = y ] || [ $bootloader = Y ]
then
	pacman -S grub efibootmgr
	grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
	grub-mkconfig -o /boot/grub/grub.cfg
else
	echo
	echo "You chose to not install grub or something went wrong..."
fi
echo

# Wifi
echo "Do you want to install wifi software? (wpa_supplicant wireless_tools NetworkManager)? (y/n)"
read wifi
if [ $wifi = y ] || [ $wifi = Y ]
then
	pacman -S wpa_supplicant wireless_tools networkmanager
else
	echo "You chose not to install wifi software..."
fi
echo

# Ethernet
echo "Do you want to install ethernet software? (DHCPCD) (y/n)"
read eth
if [ $eth = y ] || [ $eth = Y ]
then
	pacman -S dhcpcd dhclient
else
	echo "You chose not to install ethernet software..."
fi
echo
echo "End of Chroot script!"
