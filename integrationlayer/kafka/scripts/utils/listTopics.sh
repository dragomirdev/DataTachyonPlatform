#!/bin/bash
clear

echo "Listing Kafka Topics On:" $HOSTNAME:9092
/opt/kafka/bin/kafka-topics.sh --bootstrap-server $HOSTNAME:9092  --list

