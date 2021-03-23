#!/bin/bash
clear
echo "################################################"
echo "#                                              #"
echo "#                                              #"
echo "#                Geekbench 5                   #"
echo "#                Downloader                    #"
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
sleep 1
echo ""
echo ""
echo ""
echo "LETS GO!"
cd ~
wget https://cdn.geekbench.com/Geekbench-5.4.0-Linux.tar.gz
tar xf Geekbench-5.4.0-Linux.tar.gz && cd Geekbench-5.4.0-Linux/
echo "Finish, run with \"cd Geekbench-5.4.0-Linux/ && ./geekbench5"\"