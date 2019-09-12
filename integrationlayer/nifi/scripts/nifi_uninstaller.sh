#!/bin/bash
set -euxo pipefail

#USER_NAME='dtpuser'
#echo $USER_NAME

sudo -i -u dtpuser   bash << 'EOF'

echo "Uninstalling Nifi"

sudo /opt/nifi-1.9.2/bin/nifi.sh status
sudo /opt/nifi-1.9.2/bin/nifi.sh stop

rm -rf /opt/nifi-1.9.2-bin.zip
rm -rf /opt/nifi-1.9.2
rm /home/dtpuser/nifi_remote_installation.sh

ls -latr /home/dtpuser/

EOF
