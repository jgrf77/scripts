#!/bin/bash

#Look up country iso-code with ifconfig.co and set as variable iso
iso=$(curl -4 ifconfig.co/country-iso)

#create a backup of the mirrorlist
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup

#Install reflector and rsync
pacman -S reflector rsync --noconfirm --needed

#scan the 20 most recently updated mirrors from country ($iso) and update mirrorlist to contain the 5 fastest sorted rate (speed)
reflector -c $iso -f 5 -l 20 --verbose --sort rate --save /etc/pacman.d/mirrorlist

