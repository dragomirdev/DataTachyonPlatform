#!/bin/bash
source ~/.bash_profile
clear
ps -ef | grep elastic
ps -ef | grep kibana
echo "Starting Kibana"
cd /opt/elk/kibana
/opt/elk/kibana/bin/kibana --host localhost  --elasticsearch http://localhost:9200/ &

