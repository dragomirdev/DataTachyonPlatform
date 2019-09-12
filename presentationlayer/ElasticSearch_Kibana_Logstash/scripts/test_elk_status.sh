#!/bin/bash

######################### Testing Elastic-Search ###################################

echo "Checking ElasticSearch "
##curl -X GET "localhost:9200/"
ip_address=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
curl -X GET http://${ip_address}:9200
