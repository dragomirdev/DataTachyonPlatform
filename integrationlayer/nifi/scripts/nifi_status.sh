#!/bin/bash

ps -ef | grep nifi
echo "Starting Nifi"
/opt/nifi-1.9.2/bin/nifi.sh start
sleep 1m
