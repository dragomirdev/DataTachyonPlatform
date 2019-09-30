#!/bin/sh
# Delete hadoop user and it's home directory
#sudo deluser --remove-home hadoop

# Delete dtpuser user and it's home directory
#sudo deluser --remove-home dtpuser

pkill -f hive
pkill -f beeline

# Uninstall hadoop
sudo rm -rf /opt/hadoop/
sudo rm -rf /opt/hive
sudo rm -rf ~/metastore_db/
sudo rm -rf ~/derby.log
sudo rm -rf ~/beeline
sudo rm -rf ~/hiveserver2



# Run commands as hadoop user and expand variables
sudo -i -u hadoop bash << 'EOF'

echo "hadoop user"
cd

EOF


# Run commands as hadoop user and stop Hive
sudo -i -u hadoop bash << EOF

sudo systemctl stop hive
sudo rm -rf /etc/systemd/system/hive.service
sudo systemctl daemon-reload

EOF



