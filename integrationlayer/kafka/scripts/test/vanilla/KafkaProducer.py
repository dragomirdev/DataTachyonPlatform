#==========================================================
# Load libraries and constants
#==========================================================
import json
import random
import sys
import uuid
import datetime
from random import randint
from datetime import date

from KafkaUitls import getKafkaProducer

start = 0
stop = 100
noOfDecimalPlaces = 4


def getRandomFloat(start, stop):
    return round(random.uniform(start, stop), noOfDecimalPlaces)


def getRandomDateInCurrentYear():
    start_dt = date.today().replace(day=1, month=1).toordinal()
    end_dt = date.today().toordinal()
    random_day = date.fromordinal(random.randint(start_dt, end_dt))
    print(random_day)
    return random_day


def getSensorPayload(id, name, temperature, pressure, humidity, event_date, event_datetime, latitude, longitude):
    payload = '{"id": ' + str(id) + ', ' \
              '"name": "' + str(name) + str(randint(1, 10)) + '", ' \
              '"temperature": ' + str(temperature) + ', ' \
              '"pressure": ' + str(pressure) + ', ' \
              '"humidity": ' + str(humidity) + ', ' \
              '"event_date": "' + str(event_date) + '", ' \
              '"event_datetime": "' + str(event_datetime) + '", ' \
              '"latitude": ' + str(latitude) + ', ' \
              '"longitude": ' + str(longitude) + '}'
    #print("payload\n", payload)
    return payload

###


####


def sendMessages(args):
    kafka_listener = args[1]
    kafka_topic_name = args[2]
    kafka_listener = 'JP-DTP-KAFKA-VM:9092'
    kafka_topic_name = 'DTPTopic'
    producer = getKafkaProducer(kafka_listener)

    for e in range(5):
        id = str(uuid.uuid1().int)[:10]
        name = "MachineSensor"
        temperature = getRandomFloat(start, stop)
        pressure = getRandomFloat(start, stop)
        humidity = getRandomFloat(start, 50)
        event_date = getRandomDateInCurrentYear()
        latitude = getRandomFloat(start, stop)
        longitude = getRandomFloat(start, stop)
        event_datetime = datetime.datetime.utcnow().replace(tzinfo=datetime.timezone.utc).isoformat()
        print(event_datetime)
        payload = getSensorPayload(id, name, temperature, pressure, humidity, event_date, event_datetime, latitude, longitude)
        # Decoding or converting JSON format in dictionary using loads()
        dict_obj = json.loads(payload)
        #dict_obj = json.loads(json.dumps(payload, cls=DateTimeEncoder), cls=DateTimeDecoder)
        print("payload", dict_obj)
        print('Sending Messages to Kafka Topic: ' + kafka_topic_name)
        producer.send(kafka_topic_name, value=dict_obj)
        producer.flush()


if __name__ == '__main__':
    sendMessages(sys.argv)
