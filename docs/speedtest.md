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

|            Berlin             |    ID   |
|:---------------------------------------------------------------------:|---------|
| [Telekom GmbH](https://telekom.de)                                    | 30907   |
| [DNS:NET Internet Service GmbH](https://www.dns-net.de/privatkunden/) | 20507   |
|[Consultix 10G](https://www.colocationix.de/)                          | 28622   |
|AS250.net                                                              | 27322   |
|[Cronon GmbH](https://cronon.net/)                                     | 17137   |
|[dotManaged](https://dotmanaged.eu/)                                   | 36395   |
|[TELTA Citynetz GmbH](https://www.telta.de/geschaeftskunden)           | 26715   |

|         Frankfurt                                   |   ID  |
|:---------------------------------------------------:|:-----:|
|[meerfarbig GmbH & Co. KG](https://meerfarbig.net/)  | 18667 |
|[SYNLINQ](https://synlinq.de/)                       | 32298 |
|GTT.net                                              | 24380 |
|fdcservers.net                                       | 10010 |

|             Düsseldorf                |   ID  |
|:-------------------------------------:|:-----:|
|[Telekom GmbH](https://telekom.de)  | 30906 |