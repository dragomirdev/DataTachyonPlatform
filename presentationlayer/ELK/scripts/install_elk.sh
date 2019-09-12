#!/bin/bash

cd ..

echo "Initiating ElasticSearch Script"
./elasticsearch/scripts/install_elasticsearch.sh

echo "Initiating Kibana Script"
./kibana/scripts/install_kibana.sh

echo "Initiating Logstash Script"
./logstash/scripts/install_logstash.sh
