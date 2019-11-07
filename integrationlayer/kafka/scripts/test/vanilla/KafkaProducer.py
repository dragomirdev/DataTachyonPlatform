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



                                                                                                                                                                           1