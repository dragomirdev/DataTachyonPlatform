#!/bin/bash
source ~/.bash_profile
clear
echo "Stopping Kafka GUI"
ps aux | grep 'cmak' | awk '{print $2}'  | xargs kill -9


