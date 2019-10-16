#!/bin/bash

clear

DEFAULT_TOPIC_NAME=DTPTopic
input_kafka_topic=${1:-${DEFAULT_TOPIC_NAME}}

echo "Consumer Receiving Messages from Kafka Topic:" ${input_kafka_topic}
/opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server $HOSTNAME:9092 --topic ${input_kafka_topic} --from-beginning
