#!/bin/bash

set -euxo pipefail

SPARK_WORKER_IP=$1
SPARK_WORKER_NAME=$2

cd

# Add spark worker vm to hosts
sudo sed -i "$ a $SPARK_WORKER_IP $SPARK_WORKER_NAME" /etc/hosts

# Install dependecies
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install openjdk-8-jdk

sudo usermod -aG sudo hadoop

# Run commands as hadoop user and don't expand variables
sudo -i -u hadoop bash << 'EOF'

# Update bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> ~/.bashrc
echo "export SPARK_HOME=/opt/spark" >> ~/.bashrc
echo "export PYSPARK_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo "export PYSPARK_DRIVER_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Install spark
sudo mv /home/dtpuser/spark-2.4.3-bin-hadoop2.7.tgz /opt/ #CHANGED THIS FROM BEING WGET!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
cd /opt/ #SWAPPED THIS WITH LINE ABOVE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
sudo tar -zxvf spark-2.4.3-bin-hadoop2.7.tgz
sudo mv spark-2.4.3-bin-hadoop2.7 spark
sudo chown -R spark:spark spark/
sudo chmod -R 775 spark/ 
sudo rm spark-2.4.3-bin-hadoop2.7.tgz

# Configure spark
cp /opt/spark/conf/spark-env.sh.template /opt/spark/conf/spark-env.sh
echo "SPARK_WORKER_OPTS='-Dspark.worker.cleanup.enabled=true -Dspark.worker.cleanup.appDataTtl=604800'" >> /opt/spark/conf/spark-env.sh

cp /opt/spark/conf/spark-defaults.conf.template /opt/spark/conf/spark-defaults.conf
echo "spark.serializer                   org.apache.spark.serializer.KryoSerializer" >> /opt/spark/conf/spark-defaults.conf
EOF

# Run commands as hadoop user and expand variables
sudo -i -u hadoop bash << EOF

touch /opt/spark/conf/slaves
echo "$SPARK_WORKER_NAME" >> /opt/spark/conf/slaves
EOF

# ========== to manually create spark user ADDED THIS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Create spark user
#sudo adduser hadoop
# Password : bee5Haveknee5!
# Set default values

# ========== to manually add an exception to sudoers file for the users dtpuser and spark  ADDED THIS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#sudo visudo
#dtpuser ALL=(ALL) NOPASSWD: ALL
#hadoop ALL=(ALL) NOPASSWD: ALL

# ========== to manually enable passwordless ssh between spark master and worker

# on spark worker
sudo vim /etc/ssh/sshd_config
"PasswordAuthentication no" change to "PasswordAuthentication yes"
sudo service sshd reload

# on spark master
#ssh-keygen -t rsa -b 4096
#ssh-copy-id hadoop@JP-DTP-SPARK-WORKER-VM

# on spark worker
sudo vim /etc/ssh/sshd_config
"PasswordAuthentication yes" change to "PasswordAuthentication no"
sudo service sshd reload

# ==========

#START SPARK AT SYSTEM BOOT!!!!!!!!!!!!!!!!!
#START SPARK WOULD NEED TO HAVE WORKER INSTALLED FIRST!!!!!!!!!!!!!!!!!!!!!!!!!!!
