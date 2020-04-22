#!/bin/bash
source ~/.bash_profile

echo "hadoop" >> sudo ls

echo "--------------------------------------------------------"
echo "CONTINUOUS INTEGRATION/DELIVERY"
echo "--------------------------------------------------------"
echo "Stopping Jenkins"
/opt/dtp/tomcat/stopTomcat.sh &

echo "-------------------------------"
echo "INTEGRATION LAYER"
echo "-------------------------------"

echo "Stopping ZooKeeper"
/opt/dtp/kafka/stopZookeeper.sh &

echo "Stopping Kafka"
/opt/dtp/kafka/stopKafka.sh &

echo "Stopping Kafka GUI"
/opt/dtp/kafkagui/stopKafkaGui.sh &

echo "Stopping NiFi"
/opt/dtp/nifi/stopNifi.sh &
echo "-------------------"
echo "DATA LAYER"
echo "-------------------"
echo "Stopping Hadoop"
/opt/dtp/hadoop/stopHadoop.sh &


echo "Stopping Hive2"
/opt/hive/stopHiveServer2.sh &

echo “Stopping LIVY”
/opt/dtp/livy/stopLivyServer.sh &

echo “Stopping HUE”
/opt/dtp/hue/stopHueServer.sh &

echo "Stopping Spark"
/opt/dtp/spark/stopSpark.sh &

echo "-------------------------"
echo "BUSINESS LAYER"
echo "-------------------------"
echo ""
echo "Stopping TENSORBOARD"
/opt/dtp/ai/stopTensorboard.sh &

echo "---------------------------------"
echo "PRESENTATION LAYER"
echo "---------------------------------"
echo "Stopping Elastic Search"
/opt/dtp/elk/elasticsearch/stopElasticsearch.sh &
echo "Stopping Kibana"
/opt/dtp/elk/kibana/stopKibana.sh &
echo "Stopping Logstash"
/opt/dtp/elk/logstash/stopLogstash.sh &
echo "--------------------------------------------------------------"
echo "ALL DTP SERVERS HAVE BEEN STOPPED !!! "
echo "--------------------------------------------------------------"

