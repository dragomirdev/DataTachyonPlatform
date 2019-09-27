#!/bin/bash

set -euxo pipefail

cd

echo "Hue uninstallation is started"
# Removing Hue installation from Node
sudo -i -u hadoop bash << 'EOF'

# Uninstall hue, hadoop client and hive client
sudo rm -rf /opt/hue/
sudo rm -rf /opt/hadoop/
sudo rm -rf /opt/hive/

EOF


# Kill Hue process
sudo -i -u hadoop bash << EOF

# Kill Hue process
#process_id=`/bin/ps -fu $USER| grep "runcherrypyserver" | grep -v "grep" | awk '{print $2}'`
#kill -9 $process_id

sudo systemctl stop hue
sudo rm -rf /etc/systemd/system/hue.service
sudo systemctl daemon-reload

EOF

echo "Hue uninstallation is complete."
