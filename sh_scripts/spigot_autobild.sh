#!/bin/bash
clear
echo "################################################"
echo "# Version: 0.1v                                #"
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
clear

FILE=BuildTool.jar
if [ -f "$FILE" ]; then # Datei ist nicht vorhanden
    echo "Checking software packages ..."
    apt-get update
    apt-get install git default-jdk openjdk-17-jdk openjdk-17-jre -y
    clear
    echo "Checking software packages ..."
    echo -n "Which version should be built? (z.B. 1.18): "
    read;
    echo "start building Spigot-${REPLY} ..."
    sleep 2
    java -jar BuildTools.jar --rev ${REPLY}
else # Datei ist nicht vorhanden
    echo "downloading BuildTools ..."
    rm BuildTools.jar
    wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
    clear
    echo "downloading BuildTools ..."
    echo "Checking software packages ..."
    apt-get update
    apt-get install git default-jdk openjdk-17-jdk openjdk-17-jre -y
    clear
    echo "downloading BuildTools ..."
    echo "Checking software packages ..."
    echo -n "Which version should be built? (z.B. 1.18): "
    read;
    echo "start building Spigot-${REPLY} ..."
    sleep 2
    java -jar BuildTools.jar --rev ${REPLY}
fi