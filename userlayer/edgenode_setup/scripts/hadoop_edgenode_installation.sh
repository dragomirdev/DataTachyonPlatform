#!/bin/bash

set -euxo pipefail

EDGE_NODE_HOSTNAME=$1
SPARK_HOSTNAME=$2

cd

echo "Edge node setup started"

# Install dependecies
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install openjdk-8-jdk
sudo apt-get update
sudo apt-get install -y git


sudo usermod -aG sudo hadoop

# Run commands as hadoop user and don't expand variables
sudo -i -u hadoop bash << 'EOF'

cd /opt/
sudo mv /home/dtpuser/hadoop_client.zip /opt/
sudo unzip hadoop_client.zip 
sudo mv /opt/opt/hadoop /opt/
sudo chown -R hadoop:hadoop hadoop
sudo chmod -R 775 hadoop

sudo mv /home/dtpuser/hive_client.zip /opt/
sudo unzip hive_client.zip 
sudo mv /opt/opt/hive /opt/
sudo chown -R hadoop:hadoop hive
sudo chmod -R 775 hive




# Install spark
sudo mv /home/dtpuser/spark-2.4.3-bin-hadoop2.7.tgz /opt/ #CHANGED THIS FROM BEING WGET!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
cd /opt/ #SWAPPED THIS WITH LINE ABOVE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
sudo tar -zxvf spark-2.4.3-bin-hadoop2.7.tgz
sudo mv spark-2.4.3-bin-hadoop2.7 spark
sudo rm spark-2.4.3-bin-hadoop2.7.tgz

# Configure spark
sudo cp /opt/spark/conf/spark-env.sh.template /opt/spark/conf/spark-env.sh
sudo cp /opt/spark/conf/spark-defaults.conf.template /opt/spark/conf/spark-defaults.conf
sudo mv /home/dtpuser/jpyspark /opt/spark/bin/
sudo sed -i -e "s/spark_master_hostname/$SPARK_HOSTNAME/g" /opt/spark/bin/jpyspark
sudo chown -R hadoop:hadoop spark/
sudo chmod -R 775 spark/ 

echo "SPARK_WORKER_OPTS='-Dspark.worker.cleanup.enabled=true -Dspark.worker.cleanup.appDataTtl=604800'" >> /opt/spark/conf/spark-env.sh
echo "spark.serializer                   org.apache.spark.serializer.KryoSerializer" >> /opt/spark/conf/spark-defaults.conf

sudo rm -rf /opt/opt
sudo rm hadoop_client.zip hive_client.zip


# Update bashrc
echo "export JPYSPARK_DRIVER_PYTHON=jupyter" >> ~/.bashrc
echo "export JPYSPARK_DRIVER_PYTHON_OPTS='notebook --ip=0.0.0.0 --NotebookApp.token='''" >> ~/.bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> ~/.bashrc
echo "export HIVE_HOME=/opt/hive" >> ~/.bashrc
echo "export HADOOP_HOME=/opt/hadoop" >> ~/.bashrc
echo "export SPARK_HOME=/opt/spark" >> ~/.bashrc
echo "export PYSPARK_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo "export PYSPARK_DRIVER_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$HIVE_HOME/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin:$HADOOP_HOME/sbin:$PATH' >> ~/.bashrc
source ~/.bashrc

EOF

# Run commands as hadoop user and start the jpyspark
sudo -i -u hadoop bash << EOF

mkdir -p /home/hadoop/development/projects

sudo cp /home/dtpuser/jpyspark.service /etc/systemd/system/
sudo rm /home/dtpuser/jpyspark.service
sudo chmod 755 /etc/systemd/system/jpyspark.service
sudo systemctl daemon-reload
sudo systemctl start jpyspark
sudo systemctl enable jpyspark

EOF

echo "Edge node setup finished"

