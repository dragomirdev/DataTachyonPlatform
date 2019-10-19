#==========================================================
# Load libraries and constants
#==========================================================
import json
import random
from json import dumps
from kafka import KafkaProducer
import sys
import uuid

start = 0
stop = 100
noOfDecimalPlaces = 4


def getRandomFloat(start, stop):
    return round(random.uniform(start, stop), noOfDecimalPlaces)


def getSensorPayload(id, name, temperature, pressure, humidity, latitude, longitude):
    payload = '{"id": ' + str(id) + ', ' \
              '"name": "' + str(name) + '", ' \
              '"temperature": ' + str(temperature) + ', ' \
              '"pressure": ' + str(pressure) + ', ' \
              '"humidity": ' + str(humidity) + ', ' \
              '"latitude": ' + str(latitude) + ', ' \
              '"longitude": ' + str(longitude) + '}'
    # print("payload\n", payload)
    return payload


def getKafkaProducer(kafka_listener):
    producer = KafkaProducer(bootstrap_servers=[kafka_listener],
                             value_serializer=lambda x: dumps(x).encode('utf-8'))
    return producer


def sendMessages(args):
    kafka_listener = args[1]
    kafka_topic_name = args[2]
    kafka_listener = 'JP-DTP-KAFKA-VM:9092'
    kafka_topic_name = 'DTPTopic'
    producer = getKafkaProducer(kafka_listener)

    for e in range(5):
        uid = uuid.uuid1()
        id = str(uid.int)[:20]
        name = "MachineSensor123"
        temperature = getRandomFloat(start, stop)
        pressure = getRandomFloat(start, stop)
        humidity = getRandomFloat(start, 50)
        latitude = getRandomFloat(start, stop)
        longitude = getRandomFloat(start, stop)
        payload = getSensorPayload(id, name, temperature, pressure, humidity, latitude, longitude)
        # Decoding or converting JSON format in dictionary using loads()
        dict_obj = json.loads(payload)
        print("payload", dict_obj)
        print('Sending Messages to Kafka Topic: ' + kafka_topic_name)
        producer.send(kafka_topic_name, value=dict_obj)
        producer.flush()


if __name__ == '__main__':
    sendMessages(sys.argv)

