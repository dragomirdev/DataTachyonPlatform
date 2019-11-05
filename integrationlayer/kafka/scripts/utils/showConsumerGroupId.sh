#!/bin/bash

clear

DEFAULT_TOPIC_NAME=DTPTopic
input_kafka_topic=${1:-${DEFAULT_TOPIC_NAME}}

echo "Show Consumer Group IDs from Kafka Topic:" ${input_kafka_topic}
/opt/kafka/bin/kafka-consumer-groups.sh  --list --bootstrap-server  $HOSTNAME:9092
