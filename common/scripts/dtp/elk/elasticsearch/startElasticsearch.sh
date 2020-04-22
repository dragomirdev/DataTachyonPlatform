#!/bin/bash
source ~/.bash_profile
clear
ps -ef | grep elastic
echo "Starting Elasticsearch"
cd /opt/elk/elasticsearch
/opt/elk/elasticsearch/bin/elasticsearch -d -p pid

