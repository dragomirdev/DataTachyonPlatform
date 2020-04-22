#!/bin/bash
source ~/.bash_profile
clear
echo "Stopping ZooKeeper"
ps aux | grep 'zookeeper' | awk '{print $2}'  | xargs sudo kill -9


