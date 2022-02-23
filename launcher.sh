#!/bin/bash
clear
echo "################################################"
echo "# Version: 0.1v                                #"
echo "#                                              #"
echo "#                Linux-Script                  #"
echo "#                 Launcher                     #"
echo "#                                              #"
echo "#                    by                        #"
echo "#               johanneskr.de                  #"
echo "#                                              #"
echo "#                                              #"
echo "################################################"
apt install dialog
HEIGHT=15
WIDTH=70
CHOICE_HEIGHT=5
BACKTITLE="Linux-Script.sh | Launcher"
TITLE="What script would you like to launch?"
MENU="Choose one of the following options:"

OPTIONS=(1 "LAMP Installer"
         2 "Python 3 Installer"
         3 "Spigot Builder"
         4 "Ts3AudioBot Installer"
         5 "Geekbench 5 Installer"
         6 "Exit")

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
            echo "Launching LAMP Installer"
            bash <(curl -s https://raw.githubusercontent.com/mrunknownde/Linux-Script/master/sh_scripts/lamp.sh)
            ;;
        2) 
            echo "Launching Python 3 Installer"
            bash <(curl -s https://raw.githubusercontent.com/mrunknownde/Linux-Script/master/sh_scripts/python-quick-build.sh)
            ;;
        3)
            echo "Launching Spigot Builder"
            bash <(curl -s https://raw.githubusercontent.com/mrunknownde/Linux-Script/master/sh_scripts/spigot-builder.sh)
            ;;
        4)
            echo "Launching Ts3AudioBot Installer"
            bash <(curl -s https://raw.githubusercontent.com/mrunknownde/Linux-Script/master/sh_scripts/ts3audiobot.sh)
            ;;
        5)
            echo "Launching Geekbench 5 Installer"
            bash <(curl -s https://raw.githubusercontent.com/mrunknownde/Linux-Script/master/sh_scripts/geekbench.sh)
            ;;
        6)
            echo "Exiting"
            exit
            ;;
        *) # - Error
            echo "Error! Please report this bug on Github"
            echo "https://github.com/MrUnknownDE/linux-script/issues/new"
            ;;
    esac