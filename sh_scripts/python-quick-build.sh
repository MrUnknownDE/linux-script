#!/bin/bash
CPUCORES=$(grep ^processor /proc/cpuinfo | wc -l)
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
clear
echo "################################################"
echo "# Version: 1.0v                                #"
echo "#                                              #"
echo "#                Python3.9.2                   #"
echo "#                Quick Build                   #"
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

sudo apt update
sudo apt -y upgrade
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev -y
wget https://www.python.org/ftp/python/3.9.2/Python-3.9.9.tgz
tar -xf Python-3.9.9.tgz
cd Python-3.9.9
./configure --enable-optimizations
make -j $CPUCORES
sudo make altinstall
echo ""
echo "########################################"
echo ""
echo "Python3.9 is installed"
echo "lets check this with: python3.9 --version"
echo ""
echo "########################################"