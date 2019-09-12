#!/bin/bash

set -euxo pipefail

cd

# Delete spark user
sudo deluser --remove-home spark

# Uninstall spark
sudo rm -r /opt/spark/
