#!/bin/bash

###Note##
#Before running job ...
#(1) Create the users dtpuser and spark on Nifi VM
#(2) Add exception to sudoers file for the users dtpuser
#(3) Copy the public key of jenkins user on jenkins VM to dtpuser on Nifi VM
##Create Nifi User
#sudo groupadd hadoop
#sudo adduser --ingroup hadoop nifi
#### password: nifi
#### set default values
#sudo usermod -aG sudo nifi


#set -euxo pipefail

# Install dependecies
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install openjdk-8-jdk zip unzip net-tools
sudo apt -y autoremove

# Extracting Nifi
sudo rm -rf /opt/nifi-1.9.2*

sudo mv /home/dtpuser/nifi-1.9.2-bin.zip /opt/

cd /opt/
sudo chmod -R 775 nifi-1.9.2-bin.zip
sudo unzip nifi-1.9.2-bin.zip
sudo chown -R dtpuser:hadoop nifi-1.9.2
sudo chmod -R 775 nifi-1.9.2

echo "Setting NIFI PROPERTIES"
cd /opt/nifi-1.9.2/

ls -latr

#Add the values to the following properties
#nifi.ui.banner.text=
#nifi.web.http.port=8080
#nifi.sensitive.props.key=

sudo sed -i "/nifi.ui.banner.text=/ s/=.*/=DataTachyonNifi/" /opt/nifi-1.9.2/conf/nifi.properties
sudo sed -i "/nifi.web.http.port=/ s/=.*/=9090/" /opt/nifi-1.9.2/conf/nifi.properties
sudo sed -i "/nifi.sensitive.props.key=/ s/=.*/=datatachyonnifi1234/" /opt/nifi-1.9.2/conf/nifi.properties
#sudo sed '/Java home/ i     JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"' bin/nifi.sh
#sudo sed '/JAVA_HOME not set; results may vary/ i     JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"' bin/nifi.sh

cd ..

sudo chown -R hadoop:hadoop /opt/nifi-1.9.2
sudo chmod -R 775 /opt/nifi-1.9.2

whoami && hostname && pwd
ls -latr /opt/
ls -latr /opt/nifi-1.9.2
which java

#sudo -i -u hadoop   bash << 'EOF'
# Update bashrc
#echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> ~/.bashrc
#echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
export PATH=$JAVA_HOME/bin:$PATH

echo "JAVA_HOME: "$JAVA_HOME
echo "PATH: "$PATH

sudo mv /opt/nifi-1.9.2/ /opt/nifi
sudo chown -R hadoop:hadoop /opt/nifi/
sudo chmod -R 775 /opt/nifi/

echo "Installing Nifi"
sudo /opt/nifi/bin/nifi.sh install
/opt/nifi/bin/nifi.sh stop

### Note: Add the following properties inside /etc/init.d/nifi after the #!/bin/sh

### BEGIN INIT INFO
# Provides:          nifi
# Required-Start:    $all
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:
# Short-Description: Nifi Service...

sudo mv /home/hadoop/nifi.service /etc/systemd/system/
sudo chmod 755 /etc/systemd/system/nifi.service
sudo systemctl daemon-reload
sudo systemctl start nifi.service
sudo systemctl status nifi.service
sudo systemctl enable nifi.service




#Manual Start
#echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64"
#echo "JAVA_HOME: "$JAVA_HOME
#echo "PATH: "$PATH

#ps -ef | grep nifi
#echo "Starting Nifi"
#/opt/nifi/bin/nifi.sh start
#sleep 60

#echo "Checking Status of Nifi"
#/opt/nifi-1.9.2/bin/nifi.sh status

#EOF
