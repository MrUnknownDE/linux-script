#!/bin/bash
SYSTEM=$(cat /etc/issue)
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
apt-get update;

case "$SYSTEM" in 
    "Debian GNU/Linux 10 \n \l")
        apt install curl wget apt-transport-https dirmngr neofetch htop nload git -y
        echo "
        #------------------------------------------------------------------------------#
        #                   OFFICIAL DEBIAN REPOS                                      #
        #------------------------------------------------------------------------------#

        ###### Debian Main Repos
        deb http://deb.debian.org/debian/ stable main contrib non-free
        deb-src http://deb.debian.org/debian/ stable main contrib non-free

        deb http://deb.debian.org/debian/ stable-updates main contrib non-free
        deb-src http://deb.debian.org/debian/ stable-updates main contrib non-free

        deb http://deb.debian.org/debian-security stable/updates main
        deb-src http://deb.debian.org/debian-security stable/updates main

        deb http://ftp.debian.org/debian buster-backports main
        deb-src http://ftp.debian.org/debian buster-backports main" > /etc/apt/source.list
        apt update && apt upgrade -y
        echo "Have Fun with the Official Repos :)"
        ;;
    "Ubuntu 18.04.5 LTS \n \l")
        echo "
        #------------------------------------------------------------------------------#
        #                            OFFICIAL UBUNTU REPOS                             #
        #------------------------------------------------------------------------------#


        ###### Ubuntu Main Repos
        deb http://archive.ubuntu.com/ubuntu bionic main restricted
        deb http://archive.ubuntu.com/ubuntu/ bionic-security main restricted universe multiverse 
        deb http://archive.ubuntu.com/ubuntu/ bionic-updates main restricted universe multiverse
        deb http://archive.ubuntu.com/ubuntu bionic-updates main restricted

        ###### Ubuntu Update Repos
        deb http://archive.ubuntu.com/ubuntu bionic universe
        deb http://archive.ubuntu.com/ubuntu bionic-updates universe
        deb http://archive.ubuntu.com/ubuntu bionic multiverse
        deb http://archive.ubuntu.com/ubuntu bionic-updates multiverse
        deb http://archive.ubuntu.com/ubuntu bionic-backports main restricted universe multiverse
        deb http://security.ubuntu.com/ubuntu bionic-security main restricted
        deb http://security.ubuntu.com/ubuntu bionic-security universe
        deb http://security.ubuntu.com/ubuntu bionic-security multiverse" > /etc/apt/source.list
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