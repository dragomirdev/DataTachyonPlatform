#!/bin/bash

set -euxo pipefail

HADOOP_SNN_IP=$1
HADOOP_SNN_NAME=$2

HADOOP_DN_ONE_IP=$3
HADOOP_DN_ONE_NAME=$4

HADOOP_DN_TWO_IP=$5
HADOOP_DN_TWO_NAME=$6

cd

# Add hadoop 2nd name node and data node vm's to hosts
sudo sed -i "$ a $HADOOP_SNN_IP $HADOOP_SNN_NAME" /etc/hosts
sudo sed -i "$ a $HADOOP_DN_ONE_IP $HADOOP_DN_ONE_NAME" /etc/hosts
sudo sed -i "$ a $HADOOP_DN_TWO_IP $HADOOP_DN_TWO_NAME" /etc/hosts

# Install dependecies
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install openjdk-8-jdk

#Make sure hadoop user is created and the ssh keys are generated and copied across all the hadoop nodes.
sudo usermod -aG sudo hadoop

# Run commands as hadoop user and don't expand variables
sudo -i -u hadoop bash << 'EOF'

# Update bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> ~/.bashrc
echo "export HADOOP_HOME=/opt/hadoop" >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH' >> ~/.bashrc
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
EOF

# Run commands as hadoop user and expand variables
sudo -i -u hadoop bash << EOF

sed -i '/<configuration>/d' /opt/hadoop/etc/hadoop/core-site.xml
sed -i '\+</configuration>+d' /opt/hadoop/etc/hadoop/core-site.xml
echo "<configuration>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "        <property>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "                <name>fs.default.name</name>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "                <value>hdfs://$HOSTNAME:9000</value>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "        </property>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "</configuration>" >> /opt/hadoop/etc/hadoop/core-site.xml

sed -i '/<configuration>/d' /opt/hadoop/etc/hadoop/hdfs-site.xml
sed -i '\+</configuration>+d' /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "<configuration>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "        <property>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "                <name>dfs.namenode.name.dir</name>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "                <value>/home/hadoop/hadoopdata/nameNode</value>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "        </property>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "        <property>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "                <name>dfs.replication</name>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "                <value>2</value>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "        </property>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "        <property>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "                <name>dfs.secondary.http.address</name>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "                <value>$HADOOP_SNN_NAME:50090</value>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "        </property>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml
echo "</configuration>" >> /opt/hadoop/etc/hadoop/hdfs-site.xml

sed -i '/localhost/d' /opt/hadoop/etc/hadoop/workers
echo "$HADOOP_DN_ONE_NAME" >> /opt/hadoop/etc/hadoop/workers
echo "$HADOOP_DN_TWO_NAME" >> /opt/hadoop/etc/hadoop/workers

# Format The nameNode
hdfs namenode -format
EOF

#START HADOOP AT SYSTEM BOOT!!!!!!!!!!!!!!!!!
#START HADOOP WOULD NEED TO HAVE 2NN AND DATANODES INSTALLED FIRST!!!!!!!!!!!!!!!!!!!!!!!!!!!
