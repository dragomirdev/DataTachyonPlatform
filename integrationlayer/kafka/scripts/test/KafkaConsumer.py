#==========================================================
# Load libraries and constants
#==========================================================

from time import sleep
from json import dumps
from kafka import KafkaConsumer
from json import loads
import logging
import sys
import multiprocessing
import requests, re, time


logging.basicConfig(format='%(asctime)s %(levelname)-8s %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S',
                    level=logging.WARN)
logger = logging.getLogger('KafkaConsumer')
logger.setLevel(30)
TIMEOUT = 90


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

    for message in consumer:
        print(message)
        time.sleep(1)


if __name__ == '__main__':
    p = multiprocessing.Process(target=main(sys.argv), name="Foo")
    p.start()
    p.join(TIMEOUT)

    if p.is_alive():
        print('Stopping Consuming Messages')
        p.terminate()
        p.join()


