#!/bin/bash
ps -ef | grep elasticsearch
ps -ef | grep kibana

cd /opt/elk/kibana/

#sleep 1m
echo " Starting Kibana Server...."
/opt/elk/kibana/bin/kibana --host JP-DTP-ELK-VM --elasticsearch http://10.0.4.10:9200 &
