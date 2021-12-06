#!/bin/bash
##################################################
########## Hard Disk Partitioning Variable########
# ANTENTION, this script erases ALL YOU HD DATA (specified bt $HD)
HD=/dev/sda
# Boot Partition Size: /boot
BOOT_SIZE=200
# Root Partition Size: /
ROOT_SIZE=10000
# Swap partition size: /swap
SWAP_SIZE=2000
# The /home partition will occupy the remain free space

# Partitions file system
BOOT_FS=ext4
HOME_FS=ext4
ROOT_FS=ext4

######## Auxiliary variables. THIS SHOULD NOT BE ALTERED
BOOT_START=1
BOOT_END=$(($BOOT_START+$BOOT_SIZE))

SWAP_START=$BOOT_END
SWAP_END=$(($SWAP_START+$SWAP_SIZE))

ROOT_START=$SWAP_END
ROOT_END=$(($ROOT_START+$ROOT_SIZE))

HOME_START=$ROOT_END
#####################################################


#  dd bs=512 if=/dev/zero of="${HD}" count=8192
#  dd bs=512 if=/dev/zero of="${HD}" count=8192 seek=$((`blockdev --getsz "${HD}"` - 8192))

  #Clear clear partition data and set to GPT disk with 2048 alignment
  sgdisk -Z ${HD} # zap all on disk
  sgdisk -a 2048 -o ${HD} # new gpt disk 2048 alignment
  
  #Make partitions
  sgdisk -n 0:0:+650MiB -t 0:ef00 -c 0:efi "${HD}"
  sgdisk -n 0:0:+"${SWAP_SIZE}MiB" -t 0:8200 -c 0:swap "${HD}"
  sgdisk -n 0:0:+"${ROOT_SIZE}MiB" -t 0:8303 -c 0:root "${HD}"
  sgdisk -n 0:0:0 -t 0:8302 -c 0:home "${HD}"
  clear
  echo -e "\n"
  echo "Partitions created..."
  sleep 2
  clear
  
  #Format partitions
  clear
  mkswap -L swap "${HD}"\2
  mkfs.fat -F32 "${HD}"\1
  mkfs.ext4 -L root "${HD}"\3
  mkfs.ext4 -L home "${HD}"\4
  clear
  echo -e "\n"
  echo "Partitions formatted..."
  sleep 2
  clear
  
  #Mount partitions
  clear
  mount "${HD}"\3 /mnt
  mkdir /mnt/efi
  mount "${HD}"\1 /mnt/efi
  mkdir /mnt/home
  mount "${HD}"\4 /mnt/home
  swapon "${HD}"\2
  clear
  echo -e "\n"
  echo "Mounted partitions..."
  sleep 2
  clear

