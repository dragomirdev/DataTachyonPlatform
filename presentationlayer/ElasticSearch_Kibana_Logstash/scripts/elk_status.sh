#!/bin/bash

######################### Checking Elastic-Search Status###################################

echo "Checking ElasticSearch "
##curl -X GET "localhost:9200/"
ip_address=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
curl -X GET http://${ip_address}:9200
#curl  -XGET "http://${ip_address}:9200/_xpack?pretty"

######################### Checking Kibana Status###################################

echo "Checking Kibana "
##curl -X GET "localhost:5601/"
ip_address=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
curl -X GET http://${ip_address}:5601
#curl  -XGET "http://${ip_address}:5601/_xpack?pretty"

######################### Checking Logstash Status###################################

echo "Checking Logstash "
##curl -X GET "localhost:9600/"
ip_address=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
curl -X GET http://${ip_address}:9600
#curl  -XGET "http://${ip_address}:9600/_xpack?pretty"

#####################################################################################