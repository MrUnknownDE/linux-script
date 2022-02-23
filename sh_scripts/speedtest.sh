#!/bin/bash
SYSTEM=$(cat /etc/issue)
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
VERSION="Version: 1.0v"
clear
echo "$VERSION"
echo "################################################"
echo "#                                              #"
echo "#                                              #"
echo "#                 Speedtest                    #"
echo "#                 Installer                    #"
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
    "Debian")
        sudo apt-get install curl
        curl -s https://install.speedtest.net/app/cli/install.deb.sh | sudo bash
        sudo apt-get install speedtest-cli
        echo "speedtest installer has end ..."
        ;;
    "Ubuntu")
        sudo apt-get install curl
        curl -s https://install.speedtest.net/app/cli/install.deb.sh | sudo bash
        sudo apt-get install speedtest-cli
        echo "speedtest installer has end ..."
        ;;
    "Kernel \r on an \m")
        curl -s https://install.speedtest.net/app/cli/install.rpm.sh | sudo bash
        sudo yum install speedtest
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