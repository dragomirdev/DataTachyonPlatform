#!/bin/bash

ES_HOME_FOLDER=/opt/elk/elasticsearch
KIBANA_HOME_FOLDER=/opt/elk/kibana
LOGSTASH_HOME_FOLDER=/opt/elk/logstash

######################### Starting Elastic-Search###################################
ls -latr /home/dtpuser/
ls -latr ${ES_HOME}

ps -ef | grep elastic

echo " Starting Elastic-Search Server...."
# Running Elastic-Search as a Daemon
${ES_HOME}/bin/elasticsearch -d -p pid

sleep 1m

############################## Starting Kibana #######################################

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

########################### Starting LogStash #######################################
sudo chmod -R 775 /opt/elk/logstash/
sudo chmod -R 775 /opt/elk/logstash/run_logstash.sh
sudo chown -R dtpuser:dtpuser /opt/elk/logstash*

cd /opt/elk/logstash/
# Check Version
bin/logstash --version

ps -ef | grep logstash

echo " Starting LogStash Server...."
#Start Logstash
/opt/elk/logstash/bin/logstash -e 'input { stdin { } } output { stdout {} }' &

#sudo  ./opt/elk/logstash-7.2.0/run_logstash.sh
#LOGSTASH_LOG=/datadrive/elk/logstash/log/logstash.log
#nohup ${LOGSTASH_HOME}/bin/logstash  -e 'input { stdin { } } output { stdout {} }' > $LOGSTASH_LOG 2>&1 

#####################################################################################


#curl -XGET 'localhost:9600/_node/logging?pretty'


