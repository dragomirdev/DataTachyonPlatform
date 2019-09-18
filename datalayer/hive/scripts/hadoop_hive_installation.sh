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

# Update bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> ~/.bashrc
echo "export HADOOP_HOME=/opt/hadoop" >> ~/.bashrc
echo "export HIVE_HOME=/opt/hive" >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HIVE_HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

EOF

# Run commands as hadoop user and expand variables
sudo -i -u hadoop bash << EOF
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

echo " The Hive Server Configuration is Complete."
echo " To Manually start the Hive Server run the /datalayer/hive/scripts/start_hive.sh script"
