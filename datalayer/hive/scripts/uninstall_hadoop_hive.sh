#!/bin/sh
# Delete hadoop user and it's home directory
sudo deluser --remove-home hadoop

# Delete dtpuser user and it's home directory
sudo deluser --remove-home dtpuser

# Uninstall hadoop
sudo rm -r /opt/hadoop/
sudo rm -r /opt/hive
