#!/bin/bash

# To create a Kafka Topic ‘TestTopic’
/opt/kafka/bin/kafka-topics.sh --create --zookeeper $HOSTNAME:2181 --replication-factor 1 --partitions 1 --topic TestTopic


