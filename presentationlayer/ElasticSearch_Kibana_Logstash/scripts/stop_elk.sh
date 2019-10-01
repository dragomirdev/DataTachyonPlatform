#!/bin/bash

######################### Stopping ELK###################################
pkill -f elasticsearch
pkill -f logstash
pkill -f kibana


ps -ef | grep elasticsearch
ps -ef | grep kibana
ps -ef | grep logstash

