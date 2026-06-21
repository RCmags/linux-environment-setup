# Commands to fix the lenovo dock when the laptop lid is closed

# NOTE: consider DISSABLING the laptop lid switch to prevent finding the laptop display on lid close. Use must MANUALLY turn on display when undocked/docked. Edit via BIOS.

# 1. use fixed display configurations

sudo apt install pipx
pipx install autorandr

# configure displays with xfce app, then enter:
autorandr --save dock

# test the configuration with:
autorandr --load dock


# 2. Set a specific kernel [some are more stable for docks]
# https://unix.stackexchange.com/questions/198003/set-the-default-kernel-in-grub#421650

# NOTE: use update apt to select kernel version; procedure is meant to be safe

sudo nano /etc/default/grub

# append:
#GRUB_SAVEDEFAULT=true
#GRUB_DEFAULT=saved


# 3. update hardware firmware 
# https://linuxblog.io/upgrade-thinkpad-firmware-linux-fwupd/

fwupdmgr refresh --force
fwupdmgr get-updates
fwupdmgr update

