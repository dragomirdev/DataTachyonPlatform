#!/bin/bash
source ~/.bash_profile
clear

export CLASSPATH=$CLASSPATH:$HADOOP_HOME/lib/*:$HIVE_HOME/lib/*:$DERBY_HOME/lib/derby.jar:$DERBY_HOME/lib/derbytools.jar

echo “Starting HiveServer2”

cd /opt/hive

/opt/hive/bin/hive --service hiveserver2 --hiveconf hive.server2.transport.mode=binary --hiveconf  hive.server2.thrift.bind.host=127.0.0.1 --hiveconf hive.server2.thrift.port=10000  --hiveconf hive.root.logger=WARN,console 

echo "HIVESERVER2 STARTED..."


