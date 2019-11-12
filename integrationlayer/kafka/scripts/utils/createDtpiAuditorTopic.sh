#!/bin/bash
clear

DEFAULT_TOPIC_NAME=DTPiAuditorTopic
input_kafka_topic=${1:-${DEFAULT_TOPIC_NAME}}

echo "Creating Kafka Topic:" ${input_kafka_topic}
/opt/kafka/bin/kafka-topics.sh --create --zookeeper $HOSTNAME:2181 --replication-factor 1 --partitions 1 --topic ${input_kafka_topic}
