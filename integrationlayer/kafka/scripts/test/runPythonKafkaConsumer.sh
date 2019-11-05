#!/bin/bash

clear

kafka_listener='JP-DTP-KAFKA-VM:9092'
kafka_topic_name='DTPTopic'

echo "Starting Kafka Consumer"
python3 KafkaConsumer.py kafka_listener kafka_topic_name