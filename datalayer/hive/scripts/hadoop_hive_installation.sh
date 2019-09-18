#!/bin/bash

HIVE_VM_IP_ADDRESS=$1
HADOOP_NAMENODE_IP_ADDRESS=$2
set -euxo pipefail

cd

# Add hadoop name node vm to hosts

# Install dependecies
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install openjdk-8-jdk
sudo apt -y install zip unzip

#sudo useradd hadoop
#sudo mkdir /home/hadoop
sudo usermod -aG sudo hadoop
#sudo chown -R hadoop:hadoop /home/hadoop


# Run commands as hadoop user and don't expand variables
sudo -i -u hadoop bash << EOF

# Update bashrc
cat >> ~/.bashrc << INN1
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
export HADOOP_HOME=/opt/hadoop
export SPARK_HOME=/opt/spark
export HADOOP_HOME=/opt/hadoop
export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$SPARK_HOME/bin:$HADOOP_HOME/sbin:$PATH
INN1
source ~/.bashrc

# Install hadoop
sudo mv /home/hadoop/hadoop-3.1.2.tar.gz /opt/
cd /opt/
sudo tar -zxvf hadoop-3.1.2.tar.gz
sudo mv hadoop-3.1.2 hadoop
sudo chown -R hadoop:hadoop hadoop/
sudo chmod -R 775 hadoop/
sudo rm hadoop-3.1.2.tar.gz

mkdir -p /home/hadoop/hadoopdata/
chown hadoop:hadoop /home/hadoop/hadoopdata/
chmod 775 /home/hadoop/hadoopdata/

# Configure hadoop
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> /opt/hadoop/etc/hadoop/hadoop-env.sh

sed -i '/<configuration>/d' /opt/hadoop/etc/hadoop/hdfs-site.xml
sed -i '\+</configuration>+d' /opt/hadoop/etc/hadoop/hdfs-site.xml
cat >> /opt/hadoop/etc/hadoop/hdfs-site.xml << INN2
<configuration>
<property>
        <name>dfs.datanode.data.dir</name>
        <value>/home/hadoop/hadoopdata/dataNode</value>
</property>
</configuration>
INN2
EOF


sudo -i -u hadoop bash << OUTER
sed -i '/<configuration>/d' /opt/hadoop/etc/hadoop/core-site.xml
sed -i '\+</configuration>+d' /opt/hadoop/etc/hadoop/core-site.xml
cat >> /opt/hadoop/etc/hadoop/core-site.xml << INNER
<configuration>
<property>
        <name>fs.default.name</name>
        <value>hdfs://${HADOOP_NAMENODE_IP_ADDRESS}:9000</value>
</property>
</configuration>
INNER

# Install Hive
echo "************ Starting Hive installation *********"
sudo mv /home/hadoop/hive_311.zip /opt/
cd /opt/
sudo unzip hive_311.zip
sudo mv hive_311 hive
sudo chown -R hadoop:hadoop hive
sudo chmod -R 775 hive
echo "************ Position - 2 Hive installation *********"
sudo rm hive_311.zip
hdfs dfs -mkdir -p /user/hive/warehouse

hdfs dfs -mkdir -p /tmp
hdfs dfs -chmod g+w /user/hive/warehouse
hdfs dfs -chmod g+w /tmp

# Running creation of hadoop folder on hdfs
echo "************ Position - 3 Hive installation *********"
mkdir -p /tmp/hadoop/logs
mkdir -p /tmp/hadoop/hive_tmp
mkdir -p /tmp/hadoop/hive_resources
mkdir -p /tmp/hive/java

clear
echo "************ Initialising derby database *********"
# initialise derby database
/opt/hive/bin/schematool -initSchema -dbType derby --verbose

mkdir -p ~/hiveserver2
cd ~/hiveserver2

echo "************ Starting HiveServer2 *********"
# Starting HiveServer2
hive --service hiveserver2 \
  --hiveconf hive.server2.transport.mode=binary \
  --hiveconf  hive.server2.thrift.bind.host=52.183.128.193 \
  --hiveconf hive.server2.thrift.port=10000 \
  --hiveconf hive.root.logger=WARN,console &


mkdir -p ~/beeline
cd ~/beeline

######
# Hive beeline service

echo "************ Starting Beeline Service*********"
hive --service beeline
!connect jdbc:hive2://52.183.128.193:10000 hadoop hadoop
OUTER
