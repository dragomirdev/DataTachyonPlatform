#!/bin/bash

TARGET_SERVER=$1
set -euxo pipefail

cd

# Add hadoop name node vm to hosts

# Install dependecies
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install openjdk-8-jdk
sudo apt -y install unzip

#sudo useradd hadoop
#sudo mkdir /home/hadoop
sudo usermod -aG sudo hadoop
sudo usermod -aG sudo dtpuser
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
sudo mv /home/dtpuser/hadoop-3.1.2.tar.gz /opt/
cd /opt/
sudo tar -zxvf hadoop-3.1.2.tar.gz
sudo mv hadoop-3.1.2 hadoop
sudo chown -R hadoop:hadoop hadoop/
sudo chmod -R 775 hadoop/
sudo rm hadoop-3.1.2.tar.gz

mkdir /home/hadoop/hadoopdata/
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
        <value>hdfs://${TARGET_SERVER}:9000</value>
</property>
</configuration>
INNER

# Install Hive
echo "************ Starting Hive installation *********"
sudo mv /home/dtpuser/hive_311.zip /opt/
cd /opt/
sudo unzip hive_311.zip
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

echo "************ Position - 4 *********"
# initialise derby database
bin/schematool -initSchema -dbType derby --verbose

######
# Hive beeline service
hive --service beeline
!connect jdbc:hive2://52.183.128.193:10000 hadoop hadoop  
OUTER