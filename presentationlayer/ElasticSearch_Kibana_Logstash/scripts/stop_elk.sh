#!/bin/bash

######################### Stopping ELK###################################
sudo pkill -f elasticsearch
sudo pkill -f logstash
sudo pkill -f kibana