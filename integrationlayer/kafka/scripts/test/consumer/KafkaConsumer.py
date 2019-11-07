#==========================================================
# Load libraries and constants
#==========================================================

from time import sleep
from json import dumps
from kafka import KafkaConsumer
from json import loads
import logging
import sys, time
import requests, re
import click

logging.basicConfig(format='%(asctime)s %(levelname)-8s %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S',
                    level=logging.WARN)
logger = logging.getLogger('KafkaConsumer')
logger.setLevel(30)
PERIOD_OF_TIME = 60 # 1min

@click.command()
@click.option('--kafka_listener', envvar='KAFKA_LISTENER', default='JP-DTP-KAFKA-VM:9092', help='Kafka listener. example: localhost:9092')
@click.option('--kafka_topic_name', envvar='KAFKA_TOPIC_NAME', default='DTPTopic', help='Kafka Topic name')
@click.option('--kafka_consumer_group_name', envvar='KAFKA_CONSUMER_GROUP_NAME', default='my-group', help='Kafka contumer group name')
def main(kafka_listener, kafka_topic_name, kafka_consumer_group_name):

    consumer = KafkaConsumer(kafka_topic_name,
                             bootstrap_servers=kafka_listener.split(','),
                             auto_offset_reset='earliest',
                             enable_auto_commit=True,
                             group_id=kafka_consumer_group_name,
                             value_deserializer=lambda x: loads(x.decode('utf-8')))

    consumer.subscribe([kafka_topic_name])
    print('Consuming Messages from Kafka Topic: ' + kafka_topic_name)

    start = time.time()
    for message in consumer:
        print(message)
        if time.time() > start + PERIOD_OF_TIME:
            print("Stopping Consumer")
            break


if __name__ == '__main__':
    main()





