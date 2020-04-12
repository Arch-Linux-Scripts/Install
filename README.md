==== v0.0.5 ====                             
```bash
!! Only works on x86_64-efi systems !!
```
A simpel Arch Linux install script to make the installation process faster and more simple.

# Installation:
1. Boot the Arch Linux installation and make sure you have an internet connection.

2. Clone this repository
```bash
Run: pacman -Sy
And then: pacman -S git
After that: git clone https://github.com/Arch-Linux-Scripts/install.git 
```
3. chmod 777 install.sh, chroot.sh and user.sh and copy them out from the install directory to ~

4. Then run the command: ./install.sh 
Follow the instructions...

5. When the script is done, reboot and run the command: ./user.sh
Follow the instructions...
