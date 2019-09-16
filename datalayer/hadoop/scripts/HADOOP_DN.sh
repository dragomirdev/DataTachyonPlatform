#!/bin/bash

set -euxo pipefail

HADOOP_NN_IP=$1
HADOOP_NN_NAME=$2

cd

# Add hadoop name node vm to hosts
sudo sed -i "$ a $HADOOP_NN_IP $HADOOP_NN_NAME" /etc/hosts

# Install dependecies
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install openjdk-8-jdk

sudo usermod -aG sudo hadoop

# Run commands as hadoop user and don't expand variables
sudo -i -u hadoop bash << 'EOF'

# Update bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> ~/.bashrc
echo "export HADOOP_HOME=/opt/hadoop" >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH' >> ~/.bashrc
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
echo "                <value>hdfs://$HADOOP_NN_NAME:9000</value>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "        </property>" >> /opt/hadoop/etc/hadoop/core-site.xml
echo "</configuration>" >> /opt/hadoop/etc/hadoop/core-site.xml
EOF

# ========== to manually create hadoop user

# Create hadoop user
sudo adduser hadoop
# Password : bee5Haveknee5!
# Set default values

# ========== to manually add an exception to sudoers file for the users dtpuser and hadoop

sudo visudo
dtpuser ALL=(ALL) NOPASSWD: ALL
hadoop ALL=(ALL) NOPASSWD: ALL
