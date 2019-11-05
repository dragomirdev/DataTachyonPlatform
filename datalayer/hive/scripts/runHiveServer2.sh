#!/bin/bash

source ~/.bashrc
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
export HADOOP_HOME=/opt/hadoop
export HIVE_HOME=/opt/hive
echo "************ Starting HiveServer2 *********"
# Starting HiveServer2

/opt/hive/bin/hive --service hiveserver2  --hiveconf hive.server2.transport.mode=binary  --hiveconf  hive.server2.thrift.bind.host=JP-DTP-ELK-VM  --hiveconf hive.server2.thrift.port=10000  --hiveconf hive.root.logger=WARN,console &


hadoop@JP-DTP-ELK-VM:/opt/hive$ 