#==========================================================
# Load libraries and constants
#==========================================================
import json
import random
from json import dumps
from kafka import KafkaProducer
import sys
import logging

logging.basicConfig(format='%(asctime)s %(levelname)-8s %(message)s', datefmt='%Y-%m-%d %H:%M:%S', level=logging.WARN)
logger = logging.getLogger('KafkaProducer')
logger.setLevel(30)
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
              '"lat": ' + str(latitude) + ', ' \
              '"lon": ' + str(longitude) + '}'
    # print("payload\n", payload)
    return payload


def send_messages(args):
    kafka_listener = args[1]
    kafka_topic_name = args[2]

    kafka_listener = 'JP-DTP-KAFKA-VM:9092'
    kafka_topic_name = 'DTPTopic'

    producer = KafkaProducer(bootstrap_servers=[kafka_listener],
                             value_serializer=lambda x: dumps(x).encode('utf-8')) #utf-8

    for id in range(5):
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


def dummy(producer, kafka_topic_name):
    print("")
    #    for e in range(1):
    #        #payload = constructPayload(e)
    #        payload = '{  "person":  { "name":  "Kenn",  "sex":  "male",  "age":  28}}'
    #        json_payload = dumps(payload.__dict__)
    #        #json_string = escaped_json.decode('string_escape')
    #
    #        print(json_payload)
    #        #data = {'ID': e}
    #        producer.send(kafka_topic_name, value=json_payload)
    #        sleep(5)
    #payload = '{"id": 0, "name": "MachineSensor123", "temperature": 67.5905, "pressure": 63.7212, "humidity": 25.5804, "latitude": 47.9148, "longitude": 67.0776}'
    # Decoding or converting JSON format in dictionary using loads()
    #dict_obj = json.loads(payload)
    #print(dict_obj)
    #print('Sending Messages to Kafka Topic: ' + kafka_topic_name)
    #producer.send(kafka_topic_name, value=dict_obj)
    #producer.flush()


def constructPayload(id):
    payload = SensorInfo(id, 'MachineSensor123', getRandomFloat(start, stop),
                         getRandomFloat(start, stop), getRandomFloat(start, 50),
                         getRandomFloat(start, stop), getRandomFloat(start, stop))
    return payload


# {"id": 4, "name": "MachineSensor123", "temperature": 75.6384, "pressure": 4.265,
# "humidity": 1.5484, "latitude": 12.2508, "longitude": 13.2787}

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


if __name__ == '__main__':
    send_messages(sys.argv)

