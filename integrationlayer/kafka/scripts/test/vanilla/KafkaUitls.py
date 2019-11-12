import datetime
import json
from json import JSONDecoder, JSONEncoder, dumps

from kafka import KafkaProducer


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


def getKafkaProducer(kafka_listener):
    producer = KafkaProducer(bootstrap_servers=[kafka_listener],
                             value_serializer=lambda x: dumps(x, cls=DateTimeEncoder).encode('utf-8'))
    #json.loads(json.dumps(payload, cls=DateTimeEncoder), cls=DateTimeDecoder)
    return producer