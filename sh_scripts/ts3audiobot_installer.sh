#/bin/bash
# TS3AudioBot Installer
# Init
FILE="/tmp/out.$$"
GREP="/bin/grep"

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi


clear
echo "################################################"
echo "#                                              #"
echo "#                                              #"
echo "#                TS3AudioBot                   #"
echo "#                 Installer                    #"
echo "#                                              #"
echo "#                    by                        #"
echo "#               johanneskr.de                  #"
echo "#                                              #"
echo "#                                              #"
echo "################################################"

echo -n "Choose your System"
echo ""

PS3='Please choose between 1-3:: '
options=("Debian 10" "Debian 9" "Ubuntu 18.04" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Debian 10")
            echo "starting installer for Debian 10..."
            sleep 2
            echo "install system packages ..."
            apt-get install apt-transport-https pgp -y > /dev/null
            echo "install Microsoft repository ..."
            wget -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
            sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
            wget https://packages.microsoft.com/config/debian/10/prod.list
            sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
            sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
            sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list
            clear
            echo "starting installer for Debian 10..."
            echo "install system packages ..."
            echo "install Microsoft repository ..."
            echo "install Microsoft DOTNET-3.1 ..."
            apt install dotnet-sdk-2.2 dotnet-sdk-3.1 -y
            clear
            echo "starting installer for Debian 10..."
            echo "install system packages ..."
            echo "install Microsoft repository ..."
            echo "install Microsoft DOTNET-3.1 ..."
            echo "install FFMPEG and Opus ..."
            apt install ffmpeg libopus-dev -y
            clear
            echo "starting installer for Debian 10..."
            echo "install system packages ..."
            echo "install Microsoft repository ..."
            echo "install Microsoft DOTNET-3.1 ..."
            echo "install FFMPEG and Opus ..."
            echo "install youtube-dl ..."
            sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
            sudo chmod a+rx /usr/local/bin/youtube-dl
            clear
            echo "starting installer for Debian 10..."
            echo "install system packages ..."
            echo "install Microsoft repository ..."
            echo "install Microsoft DOTNET-3.1 ..."
            echo "install FFMPEG and Opus ..."
            echo "install youtube-dl ..."
            echo "install TS3AudioBot ..."
            echo "Folder: Bot"
            wget -O Bot.zip https://splamy.de/api/nightly/ts3ab/develop/download
            apt install unzip -y && unzip Bot.zip -d Bot && cd Bot/
            clear
            echo "starting installer for Debian 10..."
            echo "install system packages ..."
            echo "install Microsoft repository ..."
            echo "install Microsoft DOTNET-3.1 ..."
            echo "install FFMPEG and Opus ..."
            echo "install youtube-dl ..."
            echo "install TS3AudioBot ..."
            echo "Folder: Bot"
            echo "cleanup this install ..."
            sleep 5
            clear
            echo "################################################"
            echo "#                                              #"
            echo "#                                              #"
            echo "#                                              #"
            echo "#              Thank you for use               #"
            echo "#               this installer                 #"
            echo "#                                              #"
            echo "#                                              #"
            echo "# run this Bot with                            #"
            echo "#   > cd Bot/                                  #"
            echo "#   > dotnet TS3AudioBot.dll                   #"
            echo "#                                              #"
            echo "#                                              #"
            echo "#                                              #"
            echo "#                johanneskr.de                 #"
            echo "################################################"
            echo ""
            break
            ;;
        "Debian 9")
            echo "starting installer for Debian 9..."
            sleep 2
            echo "install system packages ..."
            apt-get install apt-transport-https pgp -y > /dev/null
            echo "install Microsoft repository ..."
            wget -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
            sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
            wget https://packages.microsoft.com/config/debian/9/prod.list
            sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
            sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
            sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list
            clear
            echo "starting installer for Debian 10..."
            echo "install system packages ..."
            echo "install Microsoft repository ..."
            echo "install Microsoft DOTNET-3.1 ..."
            apt-get install dotnet-sdk-2.2 dotnet-sdk-3.1 -y
            clear
            echo "starting installer for Debian 10..."
            echo "install system packages ..."
            echo "install Microsoft repository ..."
            echo "install Microsoft DOTNET-3.1 ..."
            echo "install FFMPEG and Opus ..."
            apt-get install ffmpeg libopus-dev -y
            clear
            echo "starting installer for Debian 10..."
            echo "install system packages ..."
            echo "install Microsoft repository ..."
            echo "install Microsoft DOTNET-3.1 ..."
            echo "install FFMPEG and Opus ..."
            echo "install youtube-dl ..."
            sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
            sudo chmod a+rx /usr/local/bin/youtube-dl
            clear
            echo "starting installer for Debian 10..."
            echo "install system packages ..."
            echo "install Microsoft repository ..."
            echo "install Microsoft DOTNET-3.1 ..."
            echo "install FFMPEG and Opus ..."
            echo "install youtube-dl ..."
            echo "install TS3AudioBot ..."
            echo "Folder: Bot"
            wget -O Bot.zip https://splamy.de/api/nightly/ts3ab/develop/download
            apt-get install unzip -y && unzip Bot.zip -d Bot && cd Bot/
            clear
            echo "starting installer for Debian 10..."
            echo "install system packages ..."
            echo "install Microsoft repository ..."
            echo "install Microsoft DOTNET-3.1 ..."
            echo "install FFMPEG and Opus ..."
            echo "install youtube-dl ..."
            echo "install TS3AudioBot ..."
            echo "Folder: Bot"
            echo "cleanup this install ..."
            sleep 5
            clear
            echo "################################################"
            echo "#                                              #"
            echo "#                                              #"
            echo "#                                              #"
            echo "#              Thank you for use               #"
            echo "#               this installer                 #"
            echo "#                                              #"
            echo "#                                              #"
            echo "# run this Bot with                            #"
            echo "#   > cd Bot/                                  #"
            echo "#   > dotnet TS3AudioBot.dll                   #"
            echo "#                                              #"
            echo "#                                              #"
            echo "#                                              #"
            echo "#                johanneskr.de                 #"
            echo "################################################"
            echo ""
            break
            ;;
        "Ubuntu 18.04")
            echo "starting installer for Ubuntu 18.04 ..."
            sleep 2
            echo "install system packages ..."
            sudo add-apt-repository universe
            sudo apt-get update
            sudo apt-get install apt-transport-https pgp -y > /dev/null
            echo "install Microsoft repository ..."
            wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
            sudo dpkg -i packages-microsoft-prod.deb -y > /dev/null
            clear
            echo "starting installer for Debian 10..."
            echo "install system packages ..."
            echo "install Microsoft repository ..."
            echo "install Microsoft DOTNET-3.1 ..."
            apt-get install dotnet-sdk-2.2 dotnet-sdk-3.1 -y
            clear
            echo "starting installer for Debian 10..."
            echo "install system packages ..."
            echo "install Microsoft repository ..."
            echo "install Microsoft DOTNET-3.1 ..."
            echo "install FFMPEG and Opus ..."
            apt-get install ffmpeg libopus-dev -y
            clear
            echo "starting installer for Debian 10..."
            echo "install system packages ..."
            echo "install Microsoft repository ..."
            echo "install Microsoft DOTNET-3.1 ..."
            echo "install FFMPEG and Opus ..."
            echo "install youtube-dl ..."
            sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
            sudo chmod a+rx /usr/local/bin/youtube-dl
            clear
            echo "starting installer for Debian 10..."
            echo "install system packages ..."
            echo "install Microsoft repository ..."
            echo "install Microsoft DOTNET-3.1 ..."
            echo "install FFMPEG and Opus ..."
            echo "install youtube-dl ..."
            echo "install TS3AudioBot ..."
            echo "Folder: Bot"
            wget -O Bot.zip https://splamy.de/api/nightly/ts3ab/develop/download
            apt-get install unzip -y && unzip Bot.zip -d Bot && cd Bot/
            clear
            echo "starting installer for Debian 10..."
            echo "install system packages ..."
            echo "install Microsoft repository ..."
            echo "install Microsoft DOTNET-3.1 ..."
            echo "install FFMPEG and Opus ..."
            echo "install youtube-dl ..."
            echo "install TS3AudioBot ..."
            echo "Folder: Bot"
            echo "cleanup this install ..."
            sleep 5
            clear
            echo "################################################"
            echo "#                                              #"
            echo "#                                              #"
            echo "#                                              #"
            echo "#              Thank you for use               #"
            echo "#               this installer                 #"
            echo "#                                              #"
            echo "#                                              #"
            echo "# run this Bot with                            #"
            echo "#   > cd Bot/                                  #"
            echo "#   > dotnet TS3AudioBot.dll                   #"
            echo "#                                              #"
            echo "#                                              #"
            echo "#                                              #"
            echo "#                johanneskr.de                 #"
            echo "################################################"
            echo ""
            break
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
