#!/bin/bash
# Wireguard-Access-Server
# Init
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
VERSION="Version: 0.1v"

clear
echo "$VERSION"
echo "################################################"
echo "#                                              #"
echo "#                                              #"
echo "#                 Wireguard                    #"
echo "#                 Installer                    #"
echo "#                                              #"
echo "#                    by                        #"
echo "#               johanneskr.de                  #"
echo "#                                              #"
echo "#                                              #"
echo "################################################"

# Docker Check
if ! which docker > /dev/null; then
   echo -e "Docker is not install! Install? (y/n) \c"
   read
   if "$REPLY" = "y"; then
      sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
      curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
      echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      sudo apt update
      apt-get install docker-ce docker-ce-cli containerd.io
   fi
   if "$REPLY" = "n"; then
      exit;
   fi
fi
if ! which docker > /dev/null; then
   echo -e "Docker Composer is not install! Install? (y/n) \c"
   read
   if "$REPLY" = "y"; then
      sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
      sudo chmod +x /usr/local/bin/docker-compose
   fi
   if "$REPLY" = "n"; then
      exit;
   fi
fi

