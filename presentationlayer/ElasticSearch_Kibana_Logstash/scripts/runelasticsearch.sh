#!/bin/bash

ps -ef | grep elastic
sudo sysctl -w vm.max_map_count=262144

cd /opt/elk/elasticsearch/

echo " Starting Elastic-Search Server...."
# Running Elastic-Search as a Daemon
/opt/elk/elasticsearch/bin/elasticsearch -d -p pid
