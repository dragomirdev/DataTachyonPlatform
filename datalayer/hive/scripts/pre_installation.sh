#!/bin/bash

# Run the following on JP-DTP-HIVE-HUE-VM for automating
# the creation of the dtpuser
sudo su -c "useradd dtpuser -s /bin/bash -m"

sudo chpasswd << 'END'
dtpuser:dtpuser
END

sudo usermod -aG sudo dtpuser

sudo su dtpuser

sudo su -
cat >> /etc/sudoers << FGUSER
dtpuser ALL=(ALL) NOPASSWD: ALL
FGUSER

exit
whoami

ssh-keygen -t rsa -f /home/dtpuser/.ssh/id_rsa -q -P ""


ssh-copy-id dtpuser2@52.183.128.193

exit


# Run the following on JP-DTP-HIVE-HUE-VM for automating
# the creation of the hadoop
sudo su -c "useradd hadoop -s /bin/bash -m"

sudo chpasswd << 'END'
hadoop:hadoop
END

sudo usermod -aG sudo hadoop

sudo su hadoop

sudo su -
cat >> /etc/sudoers << FGUSER
hadoop ALL=(ALL) NOPASSWD: ALL
FGUSER

exit
whoami

ssh-keygen -t rsa -f /home/hadoop/.ssh/id_rsa -q -P ""


# Run the following on
ssh-copy-id hadoop@52.183.128.193
