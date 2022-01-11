#!/bin/bash
# Make sure only root can run our script
VERSION="Version: 0.1v"

clear
echo "$VERSION"
echo "################################################"
echo "#                                              #"
echo "#                                              #"
echo "#                  (L)inux                     #"
echo "#                  (A)pache                    #"
echo "#                  (M)ysql                     #"
echo "#                  (P)HP                       #"
echo "#                                              #"
echo "#                    by                        #"
echo "#               johanneskr.de                  #"
echo "#                                              #"
echo "#                                              #"
echo "################################################"


echo "Domain-Name [ENTER]:"

read domainname
echo "This Domain is: $domainname"