#/bin/bash
clear
echo "################################################"
echo "#                                              #"
echo "#                                              #"
echo "#                 Debian 10                    #"
echo "#         automatically Repo edit              #"
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
apt update

apt install curl wget apt-transport-https dirmngr neofetch htop nload git -y
echo "
#------------------------------------------------------------------------------#
#                   OFFICIAL DEBIAN REPOS                    
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

echo "Have Fun with Debian 10 Official Repos :)"