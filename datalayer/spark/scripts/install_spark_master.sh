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
sudo mv /home/hadoop/spark-2.4.3-bin-hadoop2.7.tgz /opt/ #CHANGED THIS FROM BEING WGET!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
cd /opt/ #SWAPPED THIS WITH LINE ABOVE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
sudo tar -zxvf spark-2.4.3-bin-hadoop2.7.tgz
sudo mv spark-2.4.3-bin-hadoop2.7 spark
sudo rm spark-2.4.3-bin-hadoop2.7.tgz

# Configure spark
sudo cp /opt/spark/conf/spark-env.sh.template /opt/spark/conf/spark-env.sh
sudo cp /opt/spark/conf/spark-defaults.conf.template /opt/spark/conf/spark-defaults.conf
sudo chown -R hadoop:hadoop spark/
sudo chmod -R 775 spark/ 

echo "SPARK_WORKER_OPTS='-Dspark.worker.cleanup.enabled=true -Dspark.worker.cleanup.appDataTtl=604800'" >> /opt/spark/conf/spark-env.sh

echo "spark.serializer                   org.apache.spark.serializer.KryoSerializer" >> /opt/spark/conf/spark-defaults.conf
EOF

# Run commands as hadoop user and expand variables
sudo -i -u hadoop bash << EOF

touch /opt/spark/conf/slaves
echo "$SPARK_WORKER_NAME" >> /opt/spark/conf/slaves
EOF

#START SPARK AT SYSTEM BOOT!!!!!!!!!!!!!!!!!
#START SPARK WOULD NEED TO HAVE WORKER INSTALLED FIRST!!!!!!!!!!!!!!!!!!!!!!!!!!!
