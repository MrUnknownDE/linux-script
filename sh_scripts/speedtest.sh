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
    "Debian")
        sudo apt install gnupg1 apt-transport-https dirmngr -y
        export INSTALL_KEY=379CE192D401AB61
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $INSTALL_KEY
        echo "deb https://ookla.bintray.com/debian generic main" | sudo tee  /etc/apt/sources.list.d/speedtest.list
        sudo apt update
        # Other non-official binaries will conflict with Speedtest CLI
        # Example how to remove using apt-get
        sudo apt remove speedtest-cli -y
        sudo apt install speedtest -y
        echo "speedtest installer has end ..."
        ;;
    "Ubuntu")
        sudo apt install gnupg1 apt-transport-https dirmngr -y
        export INSTALL_KEY=379CE192D401AB61
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $INSTALL_KEY
        echo "deb https://ookla.bintray.com/debian generic main" | sudo tee  /etc/apt/sources.list.d/speedtest.list
        sudo apt update
        # Other non-official binaries will conflict with Speedtest CLI
        # Example how to remove using apt-get
        sudo apt remove speedtest-cli -y
        sudo apt install speedtest -y
        echo "speedtest installer has end ..."
        ;;
    "Kernel \r on an \m")
        sudo yum install wget
        wget https://bintray.com/ookla/rhel/rpm -O bintray-ookla-rhel.repo
        sudo mv bintray-ookla-rhel.repo /etc/yum.repos.d/
        # Other non-official binaries will conflict with Speedtest CLI
        # Example how to remove using yum
        # rpm -qa | grep speedtest | xargs -I {} sudo yum -y remove {}
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