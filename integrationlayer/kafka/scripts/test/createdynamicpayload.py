
import json
import random
import uuid

start = 0
stop = 100
noOfDecimalPlaces = 4

#working_payload = '{"id": 0, "name": "MachineSensor123", "temperature": 67.5905, "pressure": 63.7212, "humidity": 25.5804, "latitude": 47.9148, "longitude": 67.0776}'
#print("payload1 \n", working_payload)


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
    #print("payload\n", payload)
    return payload


for i in range(5):
    id = str(uuid.uuid1().int)
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
