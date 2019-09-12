#!/bin/bash

###Note##
#Before running job ...
#(1) Create the users dtpuser and spark on Nifi VM
#(2) Add exception to sudoers file for the users dtpuser
#(3) Copy the public key of jenkins user on jenkins VM to dtpuser on Nifi VM

#set -euxo pipefail

# Install dependecies
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install openjdk-8-jdk zip unzip net-tools
sudo apt -y autoremove

sudo mkdir -p /datadrive/elk/elasticsearch/data
sudo mkdir -p /datadrive/elk/elasticsearch/log
sudo mkdir -p /opt/elk/

sudo chown -R dtpuser:dtpuser /datadrive/elk/
sudo chmod -R 775 /datadrive/elk/
sudo chown -R dtpuser:dtpuser /opt/elk/
sudo chmod -R 775 /opt/elk/


# Extracting Nifi
sudo rm -rf /opt/elk/elasticsearch-7.2.0*

sudo chmod -R 775 /home/dtpuser/*.tar.gz
sudo chown -R dtpuser:dtpuser /home/dtpuser/*.tar.gz
sudo mv /home/dtpuser/elasticsearch-7.2.0-linux-x86_64.tar.gz /opt/elk/


####################### SETTING ELASTIC_SEARCH HOME #############################################
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export ES_HOME=/opt/elk/elasticsearch-7.2.0

echo "Setting JAVA_HOME"
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> ~/.bashrc

echo "Setting ES_HOME"
ES_HOME=/opt/elk/elasticsearch-7.2.0/
echo "export ES_HOME=/opt/elk/elasticsearch-7.2.0/" >> ~/.bashrc

#echo "export PATH=/home/dtpuser/kibana-7.2.0-linux-x86_64/bin:/home/dtpuser/logstash-7.2.0/bin:/home/dtpuser/elasticsearch-7.2.0/bin:/usr/lib/jvm/java-8-openjdk-amd64/bin:$PATH"  >> ~/.bashrc
echo "export PATH=/opt/elk/elasticsearch-7.2.0/bin:/usr/lib/jvm/java-8-openjdk-amd64/bin:$PATH" 

source ~/.bashrc
echo $JAVA_HOME
echo $ES_HOME

cd /opt/elk/
echo "Extracting ElasticSearch...."
tar -xzf elasticsearch-7.2.0-linux-x86_64.tar.gz

sudo chmod -R 775 /opt/elk/
sudo chown -R dtpuser:dtpuser /opt/elk/

ls -latr

####################### CONFIGURE ELASTIC-SEARCH #############################################

export ES_HOME=/opt/elk/elasticsearch-7.2.0
cd $ES_HOME

#Setting Virtual memory
echo $USER_NAME_PASS | sudo sysctl -w vm.max_map_count=262144

# Use a descriptive name for your cluster:
echo "cluster.name: DataTachyon-ElasticSearch-App" >> $ES_HOME/config/elasticsearch.yml

# Use a descriptive name for the node:
echo "node.name: "${HOSTNAME}"-ES-Node" >> $ES_HOME/config/elasticsearch.yml

# Path to directory where to store the data
echo "path.data: /datadrive/elk/elasticsearch/data" >> $ES_HOME/config/elasticsearch.yml

# Path to log files:
echo "path.logs: /datadrive/elk/elasticsearch/log" >> $ES_HOME/config/elasticsearch.yml

# Get IP address on eth0 interface
ip_address=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

# Set Network Host Address
echo "network.host: "${ip_address} >> $ES_HOME/config/elasticsearch.yml

# Set a custom port for HTTP
echo "http.port: 9200" >> $ES_HOME/config/elasticsearch.yml

#Important discovery and cluster formation settings
echo "discovery.seed_hosts: ['${ip_address}']" >> $ES_HOME/config/elasticsearch.yml
echo "cluster.initial_master_nodes: ['${HOSTNAME}-ES-Node']" >> $ES_HOME/config/elasticsearch.yml

# Enable automatic creation of X-Pack indices
# echo "action.auto_create_index: .monitoring*,.watches,.triggered_watches,.watcher-history*,.ml*" >> config/elasticsearch.yml
# Lock the memory on startup
# echo "bootstrap.memory_lock: true" >> config/elasticsearch.yml

# Display Contents of config/elasticsearch.yml
#cat config/elasticsearch.yml

#Configuring System Settings
sudo  sed -e '/session    required   pam_limits.so/ s/^#*/#/' -i /etc/pam.d/su

sudo chmod -R 775 /opt/elk/
sudo chown -R dtpuser:dtpuser /opt/elk/
pwd && ls -latr

######################### Running Elastic-Search###################################
ls -latr /home/dtpuser/
ls -latr ${ES_HOME}

ps -ef | grep elastic

echo " Starting Elastic-Search Server...."
# Running Elastic-Search as a Daemon
${ES_HOME}/bin/elasticsearch -d -p pid

sleep 30

######################### Testing Elastic-Search ###################################

#echo "Checking ElasticSearch "
#curl -X GET "localhost:9200/"
#ip_address=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
#curl -X GET http://${ip_address}:9200







