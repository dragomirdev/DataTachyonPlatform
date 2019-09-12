#!/bin/bash
set -euxo pipefail

#USER_NAME='dtpuser'
#echo $USER_NAME

sudo -i -u dtpuser   bash << 'EOF'

echo "Uninstalling Nifi"

sudo /opt/nifi-1.9.2/bin/nifi.sh status
sudo /opt/nifi-1.9.2/bin/nifi.sh stop

sudo rm -rf /opt/nifi-1.9.2-bin.zip
sudo rm -rf /opt/nifi-1.9.2
sudo rm /home/dtpuser/nifi_remote_installation.sh

ls -latr /home/dtpuser/

EOF
