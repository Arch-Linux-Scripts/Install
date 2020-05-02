==== v0.1.3 ====                             
```bash
!! Only works on x86_64-efi systems !!
```
A simpel Arch Linux install script to make the installation process faster and easier.

# Installation:
1. Boot the Arch Linux installation and make sure you have an internet connection

2. Clone this repository
```bash
pacman -Sy
pacman -S git
git clone https://github.com/Arch-Linux-Scripts/install.git 
```

3. chmod 777 the .sh files
```bash
cd install/
chmod 777 install.sh chroot.sh user.sh
```

4. Run the script
```bash
./install.sh 
```

5. When the script is done
```bash
reboot
Then login with username "root" and the password you chose
./user.sh
```
Done!
