#==========================================================
# Load libraries and constants
#==========================================================
import random
from time import sleep
from json import dumps
from kafka import KafkaProducer
import sys
import logging
import requests
import re
import time

logging.basicConfig(format='%(asctime)s %(levelname)-8s %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S',
                    level=logging.WARN)
logger = logging.getLogger('KafkaProducer')
logger.setLevel(30)


def main(args):
    kafka_listener = args[1]
    kafka_topic_name = args[2]

    kafka_listener = 'JP-DTP-KAFKA-VM:9092'
    kafka_topic_name = 'DTPTopic'

    producer = KafkaProducer(bootstrap_servers=[kafka_listener],
                             value_serializer=lambda x: dumps(x).encode('utf-8'))

    print('Sending Messages to Kafka Topic: ' + kafka_topic_name)
    for e in range(5):
        payload = constructPayload(e)
        json_payload = dumps(payload.__dict__)
        print(json_payload)
        #data = {'ID': e}
        producer.send(kafka_topic_name, value=json_payload)
        sleep(5)


def constructPayload(e):
    start = 0
    stop = 100
    payload = SensorInfo(e, 'MachineSensor123', getRandomFloat(start, stop),
                         getRandomFloat(start, stop), getRandomFloat(start, 50),
                         getRandomFloat(start, stop), getRandomFloat(start, stop))
    return payload


class SensorInfo:
    def __init__(self, id, name, temperature, pressure,
                 humidity, latitude, longitude):
        self.id = id
        self.name = name
        self.temperature = temperature
        self.pressure = pressure
        self.humidity = humidity
        self.latitude = latitude
        self.longitude = longitude


def getRandomFloat(start, stop):
    return random.uniform(start, stop)


if __name__ == '__main__':
    main(sys.argv)

