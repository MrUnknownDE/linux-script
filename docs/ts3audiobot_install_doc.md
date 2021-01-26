# Ts3AudioBot Install-Doc
#### Debian 10 -> Zeile 5
#### Ubuntu 19.04 -> Zeile 39


# Debian 10
**1. Install DOTNET-3.1**
```
apt install apt-transport-https gpg

wget -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
wget https://packages.microsoft.com/config/debian/10/prod.list
sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list

apt update
apt install dotnet-sdk-2.2 dotnet-sdk-3.1
```

**2. Install Opus and FFMPEG**

```apt install libopus-dev ffmpeg -y```

**3. Install Youtube-DL**
```
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
```

**4. Install Ts3AudioBot**
```
wget -O Bot.zip https://splamy.de/api/nightly/ts3ab/develop/download
apt install unzip -y && unzip Bot.zip -d Bot && cd Bot/
```

**5. Running Ts3AudioBot**

`dotnet TS3AudioBot.dll`

# Ubuntu 18.04
**1. Install DOTNET-3.1**
```
wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

add-apt-repository universe
apt update
apt install apt-transport-https
apt update
apt install dotnet-sdk-2.2 dotnet-sdk-3.1
```

**2. Install Opus and FFMPEG**

```apt install libopus-dev ffmpeg -y```

**3. Install Youtube-DL**
```
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
```

**4. Install Ts3AudioBot**
```
wget -O Bot.zip https://splamy.de/api/nightly/ts3ab/develop/download
apt install unzip -y && unzip Bot.zip -d Bot && cd Bot/
```

**5. Running Ts3AudioBot**

```dotnet TS3AudioBot.dll```  

___