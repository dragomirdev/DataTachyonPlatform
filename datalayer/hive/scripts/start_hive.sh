#!/bin/bash

HIVE_VM_IP_ADDRESS=$1
HADOOP_NAMENODE_IP_ADDRESS=$2
set -euxo pipefail

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


#Note: The following are the manual steps:

cd /opt/hive

source ~/.bashrc
export HADOOP_HOME=/opt/hadoop
export HIVE_HOME=/opt/hive

echo "************ Starting HiveServer2 *********"
# Starting HiveServer2

hive --service hiveserver2 \
  --hiveconf hive.server2.transport.mode=binary \
  --hiveconf  hive.server2.thrift.bind.host=JP-DTP-ELK-VM \
  --hiveconf hive.server2.thrift.port=10000 \
  --hiveconf hive.root.logger=WARN,console &

mkdir -p ~/beeline
cd ~/beeline

######
# Hive beeline service

echo "************ Starting Beeline Service*********"
hive --service beeline
!connect jdbc:hive2://JP-DTP-ELK-VM:10000 hadoop hadoop


