#!/bin/bash

######################### Stopping ELK###################################
pkill -f elasticsearch
pkill -f logstash
pkill -f kibana