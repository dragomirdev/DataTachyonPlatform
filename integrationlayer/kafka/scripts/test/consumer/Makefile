run:
        KAFKA_LISTENER=23.100.32.148:31000,23.100.32.148:31001,23.100.32.148:31002 KAFKA_TOPIC_NAME=my-topic KAFKA_CONSUMER_GROUP_NAME=test pipenv run python KafkaConsumer.py

setup:
        pip list|(grep pipenv && echo pipenv already installed || sudo pip install pipenv)
        pipenv install