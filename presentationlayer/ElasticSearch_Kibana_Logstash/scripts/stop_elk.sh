#!/bin/bash

######################### Stopping ELK###################################
pkill -f elasticsearch
pkill -f logstash
pkill -f kibana

sudo systemctl stop logstash
sudo systemctl stop kibana
sudo systemctl stop elasticsearch

ps -ef | pgrep -f "logstash" | xargs kill -9
ps -ef | pgrep -f "kibana" | xargs kill -9
ps -ef | pgrep -f "elasticsearch" | xargs kill -9

ps -ef | grep elasticsearch
ps -ef | grep kibana
ps -ef | grep logstash

