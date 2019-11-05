#!/bin/bash
ps -ef | grep elasticsearch
ps -ef | grep kibana
ps -ef | grep logstash
sudo systemctl stop logstash

cd /opt/elk/logstash/

/opt/elk/logstash/bin/logstash -e 'input { stdin { } } output { stdout {} }'