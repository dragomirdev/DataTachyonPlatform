#!/bin/bash

clear

DEFAULT_TOPIC_NAME=DTPTopic
input_kafka_topic=${1:-${DEFAULT_TOPIC_NAME}}
echo "Producer Sending Message to Kafka Topic:" ${input_kafka_topic}
echo "Hello, World" | /opt/kafka/bin/kafka-console-producer.sh --broker-list $HOSTNAME:9092 --topic ${input_kafka_topic} > /dev/null
