#Grafana Install on Linux 


## Install Grafana
To install the latest OSS release:
```
sudo apt install -y apt-transport-https
sudo apt install -y software-properties-common wget
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
``` 

Add this repository for stable releases:

```
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
```
After you add the repository:
```
sudo apt update
sudo apt install grafana
```

Start the server with init.d

To start the service and verify that the service has started:
```
sudo service grafana-server start
sudo service grafana-server status
```
Configure the Grafana server to start at boot:
```
sudo update-rc.d grafana-server defaults
```
**Now is Grafana available on `<Server-IP>:3000` whit `admin` and `admin`**

## Install Prometheus

```
wget https://github.com/prometheus/prometheus/releases/download/v2.24.1/prometheus-2.24.1.linux-amd64.tar.gz 
tar -xzf prometheus-2.24.1.linux-amd64.tar.gz
mv prometheus-2.24.1.linux-amd64/ /opt/prometheus-2.24.1.linux-amd64/
```
create Prometheus User
```
sudo useradd -s /sbin/false prometheus
sudo chmod 755 /opt/prometheus-2.24.1.linux-amd64/ -R
sudo chown prometheus:prometheus /opt/prometheus-2.24.1.linux-amd64/
```
create systemd file on `/etc/systemd/system/prometheus.service`
```
[Unit]
Description=Prometheus Server
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart= /opt/prometheus-2.24.1.linux-amd64/prometheus \
--config.file= /opt/prometheus-2.24.1.linux-amd64/prometheus.yml \
--storage.tsdb.path=/opt/prometheus-2.24.1.linux-amd64/ \
--web.console.templates= /opt/prometheus-2.24.1.linux-amd64/consoles \
--web.console.libraries= /opt/prometheus-2.24.1.linux-amd64/console_libraries

[Install]
WantedBy=multi-user.target
```
Lets Start Prometheus
```
sudo systemctl daemon-reload
sudo systemctl start prometheus.service
sudo systemctl enable prometheus.service
sudo systemctl status prometheus.service 
```
**Now is Prometheus available on `<Server-IP>:9090`**

## Install Node-Exporter
```
wget https://github.com/prometheus/node_exporter/releases/download/v1.1.0/node_exporter-1.1.0.linux-amd64.tar.gz
tar -xzf node_exporter-1.1.0.linux-amd64.tar.gz
mv -R node_exporter-1.1.0.linux_amd64 /opt/node_exporter-1.1.0.linux_amd64
```
create systemd file on `/etc/systemd/system/prometheus.service`
```
[Unit]

Description=node_exporter
Wants=network-online.target
After=network-online.target

[Service]

User=prometheus
Group=prometheus
Type=simple
ExecStart=/opt/node_exporter-1.1.0.linux-amd64/node_exporter

[Install]

WantedBy=multi-user.target
```
Lets Start Node-Exporter
```
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl status node_exporter
```