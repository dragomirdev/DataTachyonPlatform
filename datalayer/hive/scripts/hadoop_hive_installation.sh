#!/bin/bash

HIVE_VM_IP_ADDRESS=$1
HADOOP_NAMENODE_IP_ADDRESS=$2
set -euxo pipefail


# Install dependecies
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install openjdk-8-jdk zip unzip

# Make sure the hadoop user is already created with the ssh keys copied across all hadoop nodes.
sudo usermod -aG sudo hadoop

# Run commands as hadoop user and don't expand variables
sudo -i -u hadoop bash << 'EOF'

# Update bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> ~/.bashrc
echo "export HADOOP_HOME=/opt/hadoop" >> ~/.bashrc
echo "export HIVE_HOME=/opt/hive" >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HIVE_HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Install hadoop
sudo mv /home/hadoop/hadoop-3.1.2.tar.gz /opt/
cd /opt/
sudo tar -zxvf hadoop-3.1.2.tar.gz
sudo mv hadoop-3.1.2 hadoop
sudo chown -R hadoop:hadoop hadoop/
sudo chmod -R 775 hadoop/
sudo rm hadoop-3.1.2.tar.gz

mkdir -p /home/hadoop/hadoopdata/dataNode/
chown hadoop:hadoop /home/hadoop/hadoopdata/
chmod 775 /home/hadoop/hadoopdata/

# Configure hadoop
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> /opt/hadoop/etc/hadoop/hadoop-env.sh

sed -i '/<configuration>/d' /opt/hadoop/etc/hadoop/hdfs-site.xml
sed -i '\+</configuration>+d' /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<configuration>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "        <property>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "                <name>dfs.datanode.data.dir</name>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "                <value>/home/hadoop/hadoopdata/dataNode</value>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "        </property>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "</configuration>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
EOF

# Run commands as hadoop user and expand variables
sudo -i -u hadoop bash << EOF

sed -i '/<configuration>/d' /opt/hadoop/etc/hadoop/core-site.xml
sed -i '\+</configuration>+d' /opt/hadoop/etc/hadoop/core-site.xml
echo "<configuration>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "        <property>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "                <name>fs.default.name</name>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "                <value>hdfs://$HADOOP_NAMENODE_IP_ADDRESS:9000</value>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "        </property>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "</configuration>" >> /opt/hadoop/etc/hadoop/core-site.xml
EOF

sudo -i -u hadoop bash << EOF

echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> ~/.bashrc
echo "export HADOOP_HOME=/opt/hadoop" >> ~/.bashrc
echo "export HIVE_HOME=/opt/hive" >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HIVE_HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

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

EOF

