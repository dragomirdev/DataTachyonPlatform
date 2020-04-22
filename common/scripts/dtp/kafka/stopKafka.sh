#!/bin/bash
source ~/.bash_profile
clear
echo "Stopping Kafka"
ps aux | grep 'kafka' | awk '{print $2}'  | xargs sudo kill -9


