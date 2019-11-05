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

logging.basicConfig(format='%(asctime)s %(levelname)-8s %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S',
                    level=logging.WARN)
logger = logging.getLogger('KafkaConsumer')
logger.setLevel(30)
PERIOD_OF_TIME = 60 # 1min


def main(args):
    kafka_listener = args[1]
    kafka_topic_name = args[2]

    kafka_listener = 'JP-DTP-KAFKA-VM:9092'
    kafka_topic_name = 'DTPTopic'

    consumer = KafkaConsumer(kafka_topic_name,
                             bootstrap_servers=[kafka_listener],
                             auto_offset_reset='earliest',
                             enable_auto_commit=True,
                             group_id='my-group',
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
    main(sys.argv)





