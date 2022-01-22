#!/bin/bash

function mirrors {
   clear

	sudo pacman --needed -S reflector rsync
	
	#UPDATE MIRROR LIST
	#Look up country iso-code with ifconfig.co and set as variable iso
	iso=$(curl -4 ifconfig.co/country-iso)

	#create a backup of the mirrorlist
	sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup

	#scan the 20 most recently updated mirrors from country ($iso) and update mirrorlist to contain the 5 fastest sorted rate (speed)
	sudo reflector -c $iso -f 5 -l 20 --verbose --sort rate --save /etc/pacman.d/mirrorlist
}

function update {
   clear

	sudo pacman -Syu

}

function paccache {
   clear

	sudo pacman -Scc

}

function orphan {
   clear

	#pacman -Rs $ (pacman -Qdtq)

}

function cache {
   clear

	rm -rf .cache/*

}

function failed {
   clear

	systemctl --failed

}

function log {
   clear

	sudo journalctl -p 3 -xb

}

function dellog {
   clear

	sudo journalctl --vacuum-time=2weeks

}




function menu {
   clear
   echo
   echo -e "\t\tSystem Maintenance\n"
   echo -e "\t1. Update Mirror List (Reflector)"
   echo -e "\t2. Update System (pacman -Syu)"
   echo -e "\t3. Delete Pacman Cache (sudo pacman -Scc)"
   echo -e "\t4. Delete Orphan Packages (pacman -Rs $ (pacman -Qdtq))"
   echo -e "\t5. Delete The Cache (rm -rf .cache/*)"
   echo -e "\t6. Check Systemd Failed Services (systemctl --failed)"
   echo -e "\t7. Check Log Files (sudo journalctl -p 3 -xb)"
   echo -e "\t8. Delete Log Files (sudo journalctl --vacuum-time=2weeks)"
   echo -e "\t0. Exit\n\n"
   echo -en "\t\tEnter option: "
   read -n 1 option
}
 
while [ 1 ]
do
   menu
   case $option in
   0)
      break ;;
   1)
      mirrors ;;
   2)
      update ;;
   3)
      paccache ;;
   4)
      orphan ;;
   5)
      cache ;;
   6)
      failed ;;
   7)
      log ;;
   8)
      dellog ;;
   *)
      clear
      echo "Sorry, wrong selection";;
   esac
   echo -en "\n\n\t\t\tHit any key to continue"
   read -n 1 line
done
clear


