#!/bin/bash

### FROM https://www.geeksforgeeks.org/creating-dialog-boxes-with-the-dialog-tool-in-linux/

function installall {
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="ITI ERP"
TITLE="Web servers informations"
MENU="Choose one of the following options:"

OPTIONS=(1 "Add a new employee"
         2 "Delete an existing employee"
         3 "Query an existing employee"
         4 "List all employees"
         5 "Install web environment")
DEFAULTIP="127.0.0.1"
DATA=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
		--form "Please enter the information" 12 40 4 "1st backend IP " 1 1 "${DEFAULTIP}"  1 12 15 0 "2nd Backend IP " 2 1 "${DEFAULTIP}" 2 12 15 0 "NGINX IP " 3 1 "${DEFAULTIP}" 3 12 15 0 2>&1 > /dev/tty)
clear
SERVER1=$(echo "${DATA}" | sed -n '1p')
SERVER2=$(echo "${DATA}" | sed -n '2p')
SERVER3=$(echo "${DATA}" | sed -n '3p')
echo "Apache backend 1 ${SERVER1}"
echo "Apache backend 2 ${SERVER2}"
echo "NGINX  ${SERVER3}"
}

function mainmenu {
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="ITI ERP"
TITLE="Employee information"
MENU="Choose one of the following options:"

OPTIONS=(1 "Add a new employee"
         2 "Delete an existing employee"
         3 "Query an existing employee"
         4 "List all employees"
	 5 "Install web environment")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            echo "You chose Option 1"
            ;;
        2)
            echo "You chose Option 2"
            ;;
        3)
            echo "You chose Option 3"
            ;;
	4)
	    echo "Option 4"
	    ;;
	5)
		installall
	    ;;
esac
}

mainmenu
