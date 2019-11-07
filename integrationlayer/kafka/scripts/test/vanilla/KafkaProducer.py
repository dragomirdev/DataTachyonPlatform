#==========================================================
# Load libraries and constants
#==========================================================
import json
import random
from json import dumps
from kafka import KafkaProducer
import sys
import uuid
import datetime
from json import JSONDecoder
from json import JSONEncoder
from random import randint
from datetime import date

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

class DateTimeDecoder(json.JSONDecoder):

    def __init__(self, *args, **kargs):
        JSONDecoder.__init__(self, object_hook=self.dict_to_object,
                             *args, **kargs)

    def dict_to_object(self, d):
        if '__type__' not in d:
            return d

        type = d.pop('__type__')
        try:
            dateobj = datetime(**d)
            return dateobj
        except:
            d['__type__'] = type
            return d


class DateTimeEncoder(JSONEncoder):
    """ Instead of letting the default encoder convert datetime to string,
        convert datetime objects into a dict, which can be decoded by the
        DateTimeDecoder
    """

    def default(self, obj):
        if isinstance(obj, datetime):
            return obj.isoformat()
        else:
            return JSONEncoder.default(self, obj)

####


def getKafkaProducer(kafka_listener):
    producer = KafkaProducer(bootstrap_servers=[kafka_listener],
                             value_serializer=lambda x: dumps(x, cls=DateTimeEncoder).encode('utf-8'))
    #json.loads(json.dumps(payload, cls=DateTimeEncoder), cls=DateTimeDecoder)
    return producer


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