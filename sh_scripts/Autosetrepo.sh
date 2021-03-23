#!/bin/bash
SYSTEM=$(cat /etc/issue)
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
clear
echo "################################################"
echo "#                                              #"
echo "#                                              #"
echo "#                  Linux                       #"
echo "#          Automatically Repo edit             #"
echo "#                                              #"
echo "#                    by                        #"
echo "#               johanneskr.de                  #"
echo "#                                              #"
echo "#                                              #"
echo "################################################"
echo ""
echo ""
echo "DE >"
echo "Dieses Script startet gleich automatisch."
echo ""
echo "EN >"
echo "This script will start automatically."
sleep 5
echo ""
echo ""
echo ""
echo "LETS GO!"

case "$SYSTEM" in 
    "Debian GNU/Linux 10 \n \l")
        apt-get update
        apt install curl wget apt-transport-https dirmngr neofetch htop nload git -y
        curl "https://raw.githubusercontent.com/MrUnknownDE/linux-script/main/sh_scripts/repos/debian-10.txt" -o /etc/apt/source.list
        apt update && apt upgrade -y
        echo "Have Fun with the Official Repos :)"
        ;;
    "Debian GNU/Linux 9 \n \l")
        apt-get update 
        apt install curl wget apt-transport-https dirmngr neofetch htop nload git -y
        curl "https://raw.githubusercontent.com/MrUnknownDE/linux-script/main/sh_scripts/repos/debian-9.txt" -o /etc/apt/source.list
        apt update && apt upgrade -y
        echo "Have Fun with the Official Repos :)"
        ;;
    "Debian GNU/Linux 11 \n \l")
        apt-get update
        apt install curl wget apt-transport-https dirmngr neofetch htop nload git -y
        curl "https://raw.githubusercontent.com/MrUnknownDE/linux-script/main/sh_scripts/repos/debian-11.txt" -o /etc/apt/source.list
        apt update && apt upgrade -y
        echo "Have Fun with the Official Repos :)"
        ;;
    "Ubuntu 18.04.5 LTS \n \l")
        apt-get update
        apt-get install curl wget apt-transport-https dirmngr neofetch htop nload git -y
        curl "https://raw.githubusercontent.com/MrUnknownDE/linux-script/main/sh_scripts/repos/ubuntu-18.04.txt" -o /etc/apt/source.list
        apt-get update && apt-get upgrade -y
        echo "Have Fun with the Official Repos :)"
        ;;
    "Ubuntu 16.04.7 LTS \n \l")
        apt-get update
        apt-get install curl wget apt-transport-https dirmngr neofetch htop nload git -y
        curl "https://raw.githubusercontent.com/MrUnknownDE/linux-script/main/sh_scripts/repos/ubuntu-16.04.txt" -o /etc/apt/source.list
        apt-get update && apt-get upgrade -y
        echo "Have Fun with the Official Repos :)"
        ;;
    *)
        clear
        echo "DE >"
        echo "Dein System wird zurzeit nicht unterstützt!"
        echo ""
        echo "Schreibe doch dazu ein Issue auf Github"
        echo "> https://github.com/MrUnknownDE/linux-script/issues/new"
        echo ""
        echo ""
        echo "EN >"
        echo "Your system is currently not supported!"
        echo ""
        echo "Please write an issue on Github"
        echo "> https://github.com/MrUnknownDE/linux-script/issues/new"
esac