#!/bin/bash
source ~/.bash_profile
clear
ps -ef | grep logstash
echo "Starting Logstash"
cd /opt/elk/logstash
/opt/elk/logstash/bin/logstash -f /opt/dtp/elk/logstash/logstash-simple-dtp.conf

