#!/bin/bash
#v0.0.4
# Check for internet connection
echo "----	----"
ping www.google.com -c 1
echo "----	----"
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

# Partitioning
lsblk
echo
echo "Now you need to select what drive you want to install Arch Linux on, Example: sda"
read disk
echo "After the next choise, cfdisk are going to be opened."
echo "Please create one EFI, SWAP and ROOT partition."
echo
echo "Is this the right drive?"
echo "/dev/$disk (y/n)"
read diskcheck
if [ $diskcheck = y ] || [ $diskcheck = Y ]
then
	sudo cfdisk /dev/$disk
	echo "Now select your partitions, Example if you created an EFI partition on /dev/sda4 type: 4"
	echo "Where are your EFI partition located:"
	read efi
	echo "Where are your SWAP partition located:"
	read swap
	echo "Where are your ROOT partition located:"
	read root
	echo
	echo "Is this correct?"
	echo "EFI = /dev/$disk$efi"
	echo "SWAP = /dev/$disk$swap"
	echo "ROOT = /dev/$disk$root"
	echo "(y/n)"
else
	echo
	echo "!! You did not create any partitions !!"
	exit 1
fi
read partition
if [ $partition = y ] || [ $partition = Y ]
then
	mkfs.fat -F32 /dev/$disk$efi
	mkswap /dev/$disk$swap
	swapon /dev/$disk$swap
	mkfs.ext4 /dev/$disk$root
else
	echo
	echo "!! Partitioning failed !!"
	exit 1
fi
echo

# Base installation
echo "Do you want to continue with the installation? (y/n)"
read install
if [ $install = y ] || [ $install = Y ]
then
	mount /dev/$disk$root /mnt
	pacstrap -i /mnt base
	mkdir /mnt/boot/efi
	mount /dev/$disk$efi /mnt/boot/efi
	genfstab -U /mnt >> /mnt/etc/fstab
	cp chroot.sh /mnt
	chmod 777 /mnt/chroot.sh
	arch-chroot /mnt ./chroot.sh
else
	echo
	echo "!! Installation failed (pacstrap) !!"
	exit 1
fi
echo

# Optional !!!!!!!!!!!!!! comming later !!!!!!!!!!!!!!
#
# Window Managers...
#echo "Do you want to install i3 WM later in the installation? (y/n)"
#read wm
#if [ wm = y ] || [ wm = Y ]
#then
#	cp i3-install.sh /mnt
#	chmod 777 /mnt/i3-install.sh
#else
#	echo 
#	echo "!! Unable to copy WM file !!"
#	exit 1
#fi
echo

echo "End of script!"
echo "Your installation is BASE coplete"
echo "To create a user, boot into your new OS and run ./user.sh"
echo "(In the root directory)"
