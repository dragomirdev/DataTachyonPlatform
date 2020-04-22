#!/bin/bash
source ~/.bash_profile

echo "--------------------------------------------------------"
echo "CONTINUOUS INTEGRATION/DELIVERY"
echo "--------------------------------------------------------"
echo "Starting Jenkins"
/opt/dtp/tomcat/startTomcat.sh &

echo "-------------------------------"
echo "INTEGRATION LAYER"
echo "-------------------------------"

echo "Starting ZooKeeper"
/opt/dtp/kafka/startZookeeper.sh &

echo "Starting Kafka"
/opt/dtp/kafka/startKafka.sh &

echo "Starting Kafka GUI"
/opt/dtp/kafkagui/startKafkaGui.sh &

echo "Starting NiFi"
/opt/dtp/nifi/startNifi.sh &

echo "-------------------"
echo "DATA LAYER"
echo "-------------------"
echo "Starting Hadoop"
/opt/dtp/hadoop/startHadoop.sh &

echo "Starting Hive2"
/opt/hive/startHiveServer2.sh &

echo “Starting HUE”
/opt/dtp/hue/startHueServer.sh &

echo "Starting Spark"
/opt/dtp/spark/startSpark.sh &

echo “Starting LIVY”
/opt/dtp/livy/startLivyServer.sh &

echo "-------------------------"
echo "BUSINESS LAYER"
echo "-------------------------"
echo ""

echo “Starting TENSORBOARD”
/opt/dtp/ai/startTensorboard.sh &

echo "---------------------------------"
echo "PRESENTATION LAYER"
echo "---------------------------------"

echo "Starting Elastic Search"
/opt/dtp/elk/elasticsearch/startElasticsearch.sh &

echo "Starting Kibana"
/opt/dtp/elk/kibana/startKibana.sh &

echo "Starting Logstash"
/opt/dtp/elk/logstash/startLogstash.sh &


echo "--------------------------------------------------------------"
echo "ALL DTP SERVERS HAVE BEEN STARTED !!! "
echo "--------------------------------------------------------------"


