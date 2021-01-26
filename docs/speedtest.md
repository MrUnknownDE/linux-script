# Speedtest
![](https://img.shields.io/badge/Debian%2010-ready-brightgreen) ![](https://img.shields.io/badge/Ubuntu%2018.04-ready-brightgreen)

**Install**

```
#!/bin/bash
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
exit
```
or [https://static.syslul.de/src/sh/speedtest.sh](https://static.syslul.de/src/sh/speedtest.sh)

## Server-Liste
`speedtest --server-id=<id>`

|            Berlin             |         |
|:-----------------------------:|---------|
|          Telekom GmbH         | 30907   |
| DNS:NET Internet Service GmbH | 20507   |
|         Consultix 10G         | 28622   |
|           AS250.net           | 27322   |
|          Cronon GmbH          | 17137   |
|           dotManaged          | 36395   |
|      TELTA Citynetz GmbH      | 26715   |

|  Frankfurt   | |
|:------------:|-|
| is not found | |