#!/bin/bash

clear

kafka_listener='JP-DTP-KAFKA-VM:9092'
kafka_topic_name='DTPiAuditorTopic'

echo "Starting Kafka Producer"
python3 iAuditorKafkaProducer.py kafka_listener kafka_topic_name

