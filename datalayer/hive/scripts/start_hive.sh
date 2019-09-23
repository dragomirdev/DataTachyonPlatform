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
mkdir -p /opt/hive
cd /opt/hive

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
!connect jdbc:hive2://52.172.4.179:10000 hadoop hadoop


