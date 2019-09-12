#!/bin/bash

###Note##
#Before running job ...
#(1) Create the users dtpuser and spark on ELK VM
#(2) Add exception to sudoers file for the users dtpuser
#(3) Copy the public key of jenkins user on jenkins VM to dtpuser on ELK VM

#set -euxo pipefail

# Install dependecies
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install openjdk-8-jdk zip unzip net-tools
sudo apt -y autoremove

#Creating data directories
sudo mkdir -p /datadrive/elk/elasticsearch/data
sudo mkdir -p /datadrive/elk/elasticsearch/log
sudo mkdir -p /datadrive/elk/kibana/log/
sudo mkdir -p /datadrive/elk/kibana/data/
sudo mkdir -p /datadrive/elk/logstash/log/
sudo mkdir -p /datadrive/elk/logstash/data/
sudo mkdir -p /opt/elk/

sudo chown -R dtpuser:dtpuser /datadrive/elk/
sudo chmod -R 775 /datadrive/elk/
sudo chown -R dtpuser:dtpuser /opt/elk/
sudo chmod -R 775 /opt/elk/

sudo rm -rf /opt/elk

# Extracting ELK
sudo chmod -R 775 /home/dtpuser/ELK/
sudo chown -R dtpuser:dtpuser /home/dtpuser/ELK/
sudo mv /home/dtpuser/ELK/*.tar* /opt/elk/

pkill -f elasticsearch
pkill -f logstash
pkill -f kibana

####################### SETTING ELK HOME #############################################
ES_HOME_FOLDER=/opt/elk/elasticsearch-7.2.0/
KIBANA_HOME_FOLDER=/opt/elk/kibana-7.2.0-linux-x86_64/
LOGSTASH_HOME_FOLDER=/opt/elk/logstash-7.2.0/

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export ES_HOME=$ES_HOME_FOLDER
export KIBANA_HOME=$KIBANA_HOME_FOLDER
export LOGSTASH_HOME=$LOGSTASH_HOME_FOLDER

echo "Setting JAVA_HOME"
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> ~/.bashrc

echo "Setting ES_HOME"
echo "export ES_HOME="$ES_HOME_FOLDER >> ~/.bashrc

echo "Setting KIBANA_HOME"
echo "export KIBANA_HOME="$KIBANA_HOME_FOLDER >> ~/.bashrc

echo "Setting LOGSTASH_HOME"
echo "export LOGSTASH_HOME="$LOGSTASH_HOME_FOLDER >> ~/.bashrc

echo "export PATH=/opt/elk/kibana-7.2.0-linux-x86_64/bin:/opt/elk/logstash-7.2.0/bin:/opt/elk/elasticsearch-7.2.0/bin:/usr/lib/jvm/java-8-openjdk-amd64/bin:$PATH"  >> ~/.bashrc

source ~/.bashrc
echo "JAVA_HOME: "$JAVA_HOME
echo "ES_HOME: "$ES_HOME
echo "KIBANA_HOME: "$KIBANA_HOME
echo "LOGSTASH_HOME: "$LOGSTASH_HOME
echo "PATH: "$PATH

################################################# ELASTIC-SEARCH #############################################################
cd /opt/elk/
echo "Extracting ElasticSearch...."
tar -xzf elasticsearch-7.2.0-linux-x86_64.tar.gz

sudo chmod -R 775 /opt/elk/
sudo chown -R dtpuser:dtpuser /opt/elk/

ls -latr

########### CONFIGURE ELASTIC-SEARCH ########

#export ES_HOME=/opt/elk/elasticsearch-7.2.0
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

################################################## KIBANA ####################################################################
cd /opt/elk/
echo "Extracting Kibana...."
tar -xzf kibana-7.2.0-linux-x86_64.tar.gz

sudo chmod -R 775 /opt/elk/
sudo chown -R dtpuser:dtpuser /opt/elk/

ls -latr

########### CONFIGURE KIBANA ####################
#export KIBANA_HOME=/opt/elk/kibana-7.2.0-linux-x86_64
cd $KIBANA_HOME

# Get IP address on eth0 interface
ip_address=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

# Set Server Host Address
echo "server.host: "${ip_address} >> $KIBANA_HOME/config/kibana.yml
echo "server.port: 5601" >> $KIBANA_HOME/config/kibana.yml

# Set Kibana server's name.
echo "server.name: DataTachyon-Kibana-App" >> $KIBANA_HOME/config/kibana.yml

echo "logging.dest: /datadrive/elk/kibana/log/kibana.log" >> $KIBANA_HOME/config/kibana.yml
echo "path.data: /datadrive/elk/kibana/data/" >> $KIBANA_HOME/config/kibana.yml


echo "xpack.security.encryptionKey: DTP-Kibana-App-1234567890987654321" >>  $KIBANA_HOME/config/kibana.yml
echo "xpack.encrypted_saved_objects.encryptionKey: DTP-Kibana-App-1234567890987654321" >>  $KIBANA_HOME/config/kibana.yml

# Set the URLs of the Elasticsearch instances to use for all your queries.
echo "elasticsearch.hosts: ['http://${ip_address}:9200']"   >> $KIBANA_HOME/config/kibana.yml

# Display Contents of config/kibana.yml
#cat $KIBANA_HOME/config/kibana.yml

sudo chmod -R 775 /opt/elk/
sudo chown -R dtpuser:dtpuser /opt/elk/
pwd && ls -latr $KIBANA_HOME

#################################################### LOGSTASH #################################################################
cd /opt/elk/
echo "Extracting Logstash...."
tar -xzf logstash-7.2.0.tar.gz

sudo chmod -R 775 /opt/elk/
sudo chown -R dtpuser:dtpuser /opt/elk/

ls -latr

cd /opt/elk/logstash-7.2.0/

touch run_logstash.sh
echo "bin/logstash -e 'input { stdin { } } output { stdout {} }'"  >> run_logstash.sh

sudo chmod -R 775 /opt/elk/logstash*
sudo chown -R dtpuser:dtpuser /opt/elk/logstash*
pwd && ls -latr

# Check Version
bin/logstash --version


######################### Running Elastic-Search###################################
ls -latr /home/dtpuser/
ls -latr ${ES_HOME}

ps -ef | grep elastic

echo " Starting Elastic-Search Server...."
# Running Elastic-Search as a Daemon
${ES_HOME}/bin/elasticsearch -d -p pid

sleep 1m

############################## Running Kibana #######################################

ps -ef | grep elasticsearch

sleep 1m

# First wait for ES to start...
ip_address=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
curl -X GET http://${ip_address}:9200
#curl  -XGET "http://${ip_address}:9200/_xpack?pretty"


ps -ef | grep kibana

# Run Kibana
KIBANA_LOG=/datadrive/elk/kibana/log/kibana.log
echo " Starting Kibana Server...."
sudo rm -rf $KIBANA_LOG
ip_address=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
echo $ip_address

$KIBANA_HOME/bin/kibana --host ${HOSTNAME} --elasticsearch http://${ip_address}:9200 &

#nohup ${KIBANA_HOME}/bin/kibana --host ${HOSTNAME} --elasticsearch http://${ip_address}:9200 > $KIBANA_LOG 2>&1 &

########################### Running LogStash #######################################
sudo chmod -R 775 /opt/elk/logstash-7.2.0/
sudo chmod -R 775 /opt/elk/logstash-7.2.0/run_logstash.sh
sudo chown -R dtpuser:dtpuser /opt/elk/logstash*

cd /opt/elk/logstash-7.2.0/
# Check Version
bin/logstash --version

ps -ef | grep logstash

echo " Starting LogStash Server...."
#Start Logstash
#bin/logstash -e 'input { stdin { } } output { stdout {} }'
sudo  ./opt/elk/logstash-7.2.0/run_logstash.sh
#LOGSTASH_LOG=/datadrive/elk/logstash/log/logstash.log
#nohup ${LOGSTASH_HOME}/bin/logstash  -e 'input { stdin { } } output { stdout {} }' > $LOGSTASH_LOG 2>&1 &

#####################################################################################


#curl -XGET 'localhost:9600/_node/logging?pretty'

######################### Testing Elastic-Search ###################################

#echo "Checking ElasticSearch "
##curl -X GET "localhost:9200/"
#ip_address=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
#curl -X GET http://${ip_address}:9200


