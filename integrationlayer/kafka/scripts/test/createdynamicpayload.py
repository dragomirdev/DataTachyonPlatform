
import json
import random
import string
import uuid
import datetime
from json import JSONDecoder
from json import JSONEncoder
from random import randint
from datetime import date


start = 0
stop = 100
noOfDecimalPlaces = 4

#working_payload = '{"id": 0, "name": "MachineSensor123", "temperature": 67.5905, "pressure": 63.7212, "humidity": 25.5804, "latitude": 47.9148, "longitude": 67.0776}'
#print("payload1 \n", working_payload)

def randomStringDigits(stringLength=6):
    """Generate a random string of letters and digits """
    lettersAndDigits = string.ascii_letters + string.digits
    return ''.join(random.choice(lettersAndDigits) for i in range(stringLength))

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





for i in range(5):
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
    payload = getSensorPayload(id, name, temperature, pressure, humidity,
                               event_date, event_datetime, latitude, longitude)
    # Decoding or converting JSON format in dictionary using loads()
    dict_obj = json.loads(payload)
    #dict_obj = json.loads(json.dumps(payload, cls=DateTimeEncoder), cls=DateTimeDecoder)
    #dict_obj = json.dumps(payload, cls=DateTimeEncoder)
    print("payload", dict_obj)
    encoded_json = json.dumps(dict_obj, cls=DateTimeEncoder).encode('utf-8')
    print("encoded_json", dict_obj)
