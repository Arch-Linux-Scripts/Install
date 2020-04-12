#!/bin/bash
#v0.0.2
# Check for internet connection
echo ----	----
ping www.google.com -c 1
echo ----	----
echo Are you connected to the internet? (y/n)
read net
if [ $net = y ] || [ $net = Y ]
then
	echo Nice, lets continue...
else
	echo
	echo !! You need an internet connection to use this script !!
	exit 1
fi
echo

# Locale
echo Uncomment your locale and save
echo Continue (y/n)
read locale
if [ $locale = y ] || [ $locale = Y ]
then
	nano /etc/locale.gen
	locale-gen
else
	echo
	echo !! Failed to setup locale !!
	exit 1
fi
echo

# Hostname
echo Whats your prefered hostname?
read hostnm
echo Your hostname is set to $hostnm
echo correct? (y/n)
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
	echo !! Failed to setup hostname !!
	exit 1
fi
echo

# Password
passwd

# Bootloader
echo Do you want to install -grub- bootloader?
echo (y/n)
read bootloader
if [ $bootloader = y ] || [ $bootloader = Y ]
then
	pacman -S grub efibootmgr
	grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
	grub-mkconfig -o /boot/grub/grub.cfg
else
	echo
	echo You chose to not install grub or something went wrong...
fi
echo

# Wifi
echo Do you want to install wifi software, dialog iw wpa_supplicant? (y/n)
read wifi
if [ $wifi = y ] || [ $wifi = Y ]
then
	pacman -S dialog iw wpa_supplicant
else
	echo You chose not to install wifi software...
fi
echo

# Time zone
echo Set your timezone by running the command: 
echo ln -sf /usr/share/Region/City /etc/localtime
echo Change Region and City to your location, start with capital letter.
echo
hwclock --systohc
echo
echo End of Chroot script!
