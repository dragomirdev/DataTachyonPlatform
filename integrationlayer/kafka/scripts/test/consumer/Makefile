run:
	KAFKA_LISTENER=13.78.135.163:19090,13.78.135.163:19091,13.78.135.163:19092 KAFKA_TOPIC_NAME=my-topic KAFKA_CONSUMER_GROUP_NAME=test pipenv run python KafkaConsumer.py

setup:
	pip list|(grep pipenv && echo pipenv already installed || sudo pip install pipenv)
	pipenv install
