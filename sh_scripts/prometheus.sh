#/bin/bash
clear
echo "################################################"
echo "#                                              #"
echo "#                                              #"
echo "#             Prometheus + Grafana             #"
echo "#               Quick Installer                #"
echo "#                                              #"
echo "#                    by                        #"
echo "#               johanneskr.de                  #"
echo "#                                              #"
echo "#                                              #"
echo "################################################"
echo ""
echo ""
echo "DE >"
echo "Dieses Script startet gleich automatisch. Es installiert Prometheus + Node_Exporter automatisch, so das du es dann bei Grafana gleich einbinden kannst."
echo ""
echo "EN >"
echo "This script will start automatically. It installs Prometheus + Node_Exporter automatically, so that you can integrate it into Grafana right away."
sleep 5
echo ""
echo ""
echo ""
echo "LETS GO!"

sudo groupadd --system prometheus
sudo useradd -s /sbin/nologin --system -g prometheus prometheus
sudo mkdir /var/lib/prometheus
for i in rules rules.d files_sd; do sudo mkdir -p /etc/prometheus/${i}; done

sudo apt-get -y install wget
mkdir -p /tmp/prometheus && cd /tmp/prometheus
curl -s "https://api.github.com/repos/prometheus/prometheus/releases/latest" \
  | grep browser_download_url \
  | grep linux-amd64 \
  | cut -d '"' -f 4 \
  | wget -qi -

tar xvf prometheus*.tar.gz
cd prometheus*/
sudo mv prometheus promtool /usr/local/bin/
sudo mv prometheus.yml  /etc/prometheus/prometheus.yml
sudo echo "
# my global config
global:
  scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
    - targets: ['localhost:9090']
  
  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']" > /etc/prometheus/prometheus.yml

sudo echo "
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=prometheus
Group=prometheus
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.external-url=

SyslogIdentifier=prometheus
Restart=always

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/prometheus.service
for i in rules rules.d files_sd; do sudo chown -R prometheus:prometheus /etc/prometheus/${i}; done
for i in rules rules.d files_sd; do sudo chmod -R 775 /etc/prometheus/${i}; done
sudo chown -R prometheus:prometheus /var/lib/prometheus/

echo "Install Node_Exporter"
curl -s "https://api.github.com/repos/prometheus/node_exporter/releases/latest" \
| grep browser_download_url \
| grep linux-amd64 \
| cut -d '"' -f 4 \
| wget -qi -

tar -xvf node_exporter*.tar.gz
cd  node_exporter*/
sudo cp node_exporter /usr/local/bin

sudo echo "
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target" > /etc/systemd/system/node_exporter.service


sudo apt install -y apt-transport-https
sudo apt install -y software-properties-common wget
wget -q -O - "https://packages.grafana.com/gpg.key" | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt update
sudo apt install grafana -y



sudo systemctl daemon-reload
sudo systemctl enable grafana-server.service
sudo systemctl enable node_exporter
sudo systemctl enable prometheus
sudo systemctl start node_exporter
sudo systemctl start prometheus
sudo systemctl start grafana-server




echo "###############################################################################"
echo ""
echo "DE >"
echo "Wenn alles geklappt hat, funktioniert Prometheus und Node_Exporter wunderbar!"
echo "Beides kannst du unter http://<IP>:9090/, http://<IP>:9100"
echo "und"
echo "http://<IP>:3000/ erreichen"
echo "EN >"
echo "If everything went well, Prometheus and Node_Exporter will work wonderfully!"
echo "You can access both at http://<IP>:9090/, http://<IP>:9100"
echo "and"
echo "http://<IP>:3000/ to reach"
echo ""
echo "###############################################################################"