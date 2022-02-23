#!/bin/bash
SYSTEM=$(lsb_release -sr)
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
clear
echo "################################################"
echo "# Version: 0.1v                                #"
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

if [ "$SYSTEM" == "11" ]; then
    curl "https://raw.githubusercontent.com/MrUnknownDE/linux-script/main/sh_scripts/repos/debian-11.txt" -o /etc/apt/sources.list
    apt-get update && apt-get upgrade -y
    apt-get install curl wget apt-transport-https dirmngr neofetch htop nload git -y
    echo "Have Fun with the Official Repos :)"
fi
if [ "$SYSTEM" == "10" ]; then
    curl "https://raw.githubusercontent.com/MrUnknownDE/linux-script/main/sh_scripts/repos/debian-10.txt" -o /etc/apt/sources.list
    apt-get update && apt-get upgrade -y
    apt-get install curl wget apt-transport-https dirmngr neofetch htop nload git -y
    echo "Have Fun with the Official Repos :)"
fi
if [ "$SYSTEM" == "9" ]; then
    curl "https://raw.githubusercontent.com/MrUnknownDE/linux-script/main/sh_scripts/repos/debian-9.txt" -o /etc/apt/sources.list
    apt-get update && apt-get upgrade -y
    apt-get install curl wget apt-transport-https dirmngr neofetch htop nload git -y
    echo "Have Fun with the Official Repos :)"
fi
if [ "$SYSTEM" == "20.04" ]; then
    curl "https://raw.githubusercontent.com/MrUnknownDE/linux-script/main/sh_scripts/repos/ubuntu-20.04.txt" -o /etc/apt/sources.list
    apt-get update && apt-get upgrade -y
    apt-get install curl wget apt-transport-https dirmngr neofetch htop nload git -y
    echo "Have Fun with the Official Repos :)"
fi
if [ "$SYSTEM" == "18.04" ]; then
    curl "https://raw.githubusercontent.com/MrUnknownDE/linux-script/main/sh_scripts/repos/ubuntu-18.04.txt" -o /etc/apt/sources.list
    apt-get update && apt-get upgrade -y
    apt-get install curl wget apt-transport-https dirmngr neofetch htop nload git -y
    echo "Have Fun with the Official Repos :)"
fi
if [ "$SYSTEM" ==  "16.04" ]; then
    curl "https://raw.githubusercontent.com/MrUnknownDE/linux-script/main/sh_scripts/repos/ubuntu-16.04.txt" -o /etc/apt/sources.list
    apt-get update && apt-get upgrade -y
    apt-get install curl wget apt-transport-https dirmngr neofetch htop nload git -y
    echo "Have Fun with the Official Repos :)"
fi