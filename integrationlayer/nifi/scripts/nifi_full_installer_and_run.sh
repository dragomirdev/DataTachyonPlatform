#!/bin/bash

#Install packages and export environment variables
echo "nvidia" | sudo -kS  apt  -y upgrade
echo "nvidia" | sudo -kS  apt  -y update
echo 'nvidia' | sudo -kS apt -y install openjdk-8-jdk zip unzip net-tools

#Create Nifi User
sudo groupadd hadoop
sudo adduser --ingroup hadoop nifi
#### password: nifi
#### set default values
sudo usermod -aG sudo nifi

#Create Storage Directory for Nifi
export STORAGE_HOME=/datadrive
echo $STORAGE_HOME
sudo mkdir -p $STORAGE_HOME/nifi_home/config
sudo mkdir -p $STORAGE_HOME/nifi_home/template
sudo mkdir -p $STORAGE_HOME/nifi_home/edge-node/data/input
sudo mkdir -p $STORAGE_HOME/nifi_home/edge-node/data/backup
sudo mkdir -p $STORAGE_HOME/nifi_home/edge-nodedata/output
sudo mkdir -p $STORAGE_HOME/nifi_home/edge-node/data/error
sudo chown -R nifi:hadoop $STORAGE_HOME/nifi_home
sudo chmod -R 775 $STORAGE_HOME/nifi_home

echo 'nvidia' | sudo -kS  wget http://mirror.vorboss.net/apache/nifi/1.9.2/nifi-1.9.2-bin.zip
sudo chmod -R 775 nifi-1.9.2-bin.zip
sudo unzip nifi-1.9.2-bin.zip
#sudo chown -R nifi:hadoop nifi-1.9.2
sudo chmod -R 775 nifi-1.9.2
cd nifi-1.9.2/



echo "Setting NIFI PROPERTIES"
#Add the values to the following properties
#nifi.ui.banner.text=
#nifi.web.http.port=8080
#nifi.sensitive.props.key=

sudo sed -i "/nifi.ui.banner.text=/ s/=.*/=DataTachyonNifi/" conf/nifi.properties
sudo sed -i "/nifi.web.http.port=/ s/=.*/=9090/" conf/nifi.properties
sudo sed -i "/nifi.sensitive.props.key=/ s/=.*/=datatachyonnifi1234/" conf/nifi.properties

cd ..
sudo mv  nifi-1.9.2/ /opt/
cd /opt/
sudo chown -R nifi:hadoop nifi-1.9.2
echo "Setting JAVA_HOME"
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> ~/.bashrc
echo "export PATH=/usr/lib/jvm/java-8-openjdk-amd64/bin:$PATH"  >> ~/.bashrc
source ~/.bashrc
cat ~/.bashrc
which java

sed '/JAVA_HOME not set; results may vary/ a     JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' bin/nifi.sh

sudo chmod -R 775 nifi-1.9.2
sudo /opt/nifi-1.9.2/bin/nifi.sh install
sudo /opt/nifi-1.9.2/bin/nifi.sh start
sudo /opt/nifi-1.9.2/bin/nifi.sh status
