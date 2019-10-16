#==========================================================
# Load libraries and constants
#==========================================================

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

    print('Sending Messages to Kafka Topic: ' + kafka_topic_name)

    for e in range(5):
        payload = SensorInfo(e, 'MachineSensor123', 30, 100, 20, 22.1, 25.1)
        payload_data = dumps(payload.__dict__)
        print(payload_data)
        #data = {'ID': e}
        producer.send(kafka_topic_name, value=payload_data)
        sleep(5)


if __name__ == '__main__':
    main(sys.argv)

