#!/bin/bash
clear
echo "################################################"
echo "#                                              #"
echo "#                                              #"
echo "#              Spigot Buildtool                #"
echo "#              Autostart Script                #"
echo "#                                              #"
echo "#                    by                        #"
echo "#               johanneskr.de                  #"
echo "#                                              #"
echo "#                                              #"
echo "################################################"
echo ""
echo ""
echo "DE >"
echo "Dieses Script startet gleich automatisch. Es holt die aktuellste Version vom \"BuildTool\" und startet dann gleich damit."
echo ""
echo "EN >"
echo "This script starts automatically. It gets the latest version of the \"BuildTool\" and then starts with it"
sleep 5
echo ""
echo ""
echo ""
echo ""

rm BuildTools.jar
wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
clear

echo "Checking software packages ..."
apt-get update
apt-get install git default-jdk -y
echo "start building ..."
sleep 2
java -jar BuildTools.jar
