#!/bin/bash

pkill -f elasticsearch
pkill -f logstash
pkill -f kibana

ls -latr /opt/elk/
ls -latr /home/dtpuser/

sudo rm -rf /opt/elk
sudo rm -rf /home/dtpuser/ELK
sudo 

ls -latr  /home/dtpuser
ls -latr  /opt/
