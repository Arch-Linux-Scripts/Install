==== v0.1.1 ====                             
```bash
!! Only works on x86_64-efi systems !!
```
A simpel Arch Linux install script to make the installation process faster and easier.

# Installation:
1. Boot the Arch Linux installation and make sure you have an internet connection

2. Clone this repository
```bash
Run: pacman -Sy
And then: pacman -S git
After that: git clone https://github.com/Arch-Linux-Scripts/install.git 
```

3. chmod 777 the .sh files
```bash
Run: chmod 777 install.sh chroot.sh user.sh
```

4. Run the script
```bash
Run: ./install.sh 
```

5. When the script is done
```bash
Run: reboot
Then login with username "root" and the password you chose
After that run: ./user.sh
```
Done!
