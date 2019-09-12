#!/bin/bash

###Note##
#Before running job ...
#(1) Create the users dtpuser and spark on Nifi VM
#(2) Add exception to sudoers file for the users dtpuser
#(3) Copy the public key of jenkins user on jenkins VM to dtpuser on Nifi VM

#set -euxo pipefail

sudo mkdir -p /datadrive/elk/kibana/log/
sudo mkdir -p /datadrive/elk/kibana/data/
sudo mkdir -p /opt/elk/

sudo chown -R dtpuser:dtpuser /datadrive/elk/
sudo chmod -R 775 /datadrive/elk/
sudo chown -R dtpuser:dtpuser /opt/elk/
sudo chmod -R 775 /opt/elk/

# Extracting Nifi
sudo rm -rf /opt/elk/kibana*

sudo chmod -R 775 /home/dtpuser/*.tar.gz
sudo chown -R dtpuser:dtpuser /home/dtpuser/*.tar.gz
sudo mv /home/dtpuser/kibana-7.2.0-linux-x86_64.tar.gz  /opt/elk/


####################### SETTING KIBANA HOME #############################################
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export ES_HOME=/opt/elk/elasticsearch-7.2.0
export KIBANA_HOME=/home/dtpuser/kibana-7.2.0-linux-x86_64

echo "Setting JAVA_HOME"
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> ~/.bashrc

echo "Setting ES_HOME"
ES_HOME=/home/dtpuser/elasticsearch-7.2.0/
echo "export ES_HOME=/home/dtpuser/elasticsearch-7.2.0/" >> ~/.bashrc

echo "Setting KIBANA_HOME"
KIBANA_HOME=/home/dtpuser/kibana-7.2.0-linux-x86_64/
echo "export KIBANA_HOME=/home/dtpuser/kibana-7.2.0-linux-x86_64/" >> ~/.bashrc

echo "export PATH=/home/dtpuser/kibana-7.2.0-linux-x86_64/bin:/home/dtpuser/elasticsearch-7.2.0/bin:/usr/lib/jvm/java-8-openjdk-amd64/bin:$PATH"

source ~/.bashrc
echo $JAVA_HOME
echo $ES_HOME
echo $KIBANA_HOME

cd /opt/elk/
echo "Extracting Kibana...."
tar -xzf kibana-7.2.0-linux-x86_64.tar.gz

sudo chmod -R 775 /opt/elk/
sudo chown -R dtpuser:dtpuser /opt/elk/

ls -latr


####################### INSTALL KIBANA #############################################
export KIBANA_HOME=/opt/elk/kibana-7.2.0-linux-x86_64
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

############################## Running Kibana #######################################

ps -ef | grep elasticsearch

sleep 50s

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

######################### Testing Elastic-Search ###################################

#echo "Checking ElasticSearch "
##curl -X GET "localhost:9200/"
#ip_address=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
#curl -X GET http://${ip_address}:9200
