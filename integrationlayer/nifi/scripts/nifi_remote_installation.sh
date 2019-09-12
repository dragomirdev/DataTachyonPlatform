#!/bin/bash

###Note##
#Before running job ...
#(1) Create the users dtpuser and spark on Nifi VM
#(2) Add exception to sudoers file for the users dtpuser
#(3) Copy the public key of jenkins user on jenkins VM to dtpuser on Nifi VM


set -euxo pipefail

# Install dependecies
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install openjdk-8-jdk

sudo -i -u dtpuser   bash << 'EOF'
# Update bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Extracting Nifi
sudo mv /home/dtpuser/nifi-1.9.2-bin.zip /opt/
sudo mv /home/dtpuser/nifi_remote_installation.sh /opt/

cd /opt/
sudo chmod -R 775 nifi-1.9.2-bin.zip
sudo unzip nifi-1.9.2-bin.zip
sudo chown -R dtpuser:hadoop nifi-1.9.2
sudo chmod -R 775 nifi-1.9.2

echo "Setting NIFI PROPERTIES"
sudo unzip nifi-1.9.2-bin.zip
cd /opt/nifi-1.9.2/
#Add the values to the following properties
#nifi.ui.banner.text=
#nifi.web.http.port=8080
#nifi.sensitive.props.key=

sudo sed -i "/nifi.ui.banner.text=/ s/=.*/=DataTachyonNifi/" conf/nifi.properties
sudo sed -i "/nifi.web.http.port=/ s/=.*/=9090/" conf/nifi.properties
sudo sed -i "/nifi.sensitive.props.key=/ s/=.*/=datatachyonnifi1234/" conf/nifi.properties
#sudo sed '/Java home/ i     JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"' bin/nifi.sh
#sudo sed '/JAVA_HOME not set; results may vary/ i     JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"' bin/nifi.sh

cd ..

sudo chown -R dtpuser:hadoop nifi-1.9.2
sudo chmod -R 775 nifi-1.9.2

#sudo echo "export PATH=/usr/lib/jvm/java-8-openjdk-amd64/bin:$PATH"  >> /etc/environment

source ~/.bashrc
cat ~/.bashrc


whoami && hostname && pwd
ls -latr /opt/
ls -latr /opt/nifi-1.9.2
which java
#echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64"
#echo "JAVA_HOME: "$JAVA_HOME
#echo "PATH: "$PATH

echo "Installing Nifi"
sudo /opt/nifi-1.9.2/bin/nifi.sh install
/opt/nifi-1.9.2/bin/nifi.sh stop

#echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64"
#echo "JAVA_HOME: "$JAVA_HOME
#echo "PATH: "$PATH
ps -ef | grep nifi
echo "Starting Nifi"
/opt/nifi-1.9.2/bin/nifi.sh start
echo "Checking Status of Nifi"
/opt/nifi-1.9.2/bin/nifi.sh status

EOF
