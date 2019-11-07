run:
	KAFKA_LISTENER=13.78.135.163:30795,13.78.135.163:30527,13.78.135.163:32248 KAFKA_TOPIC_NAME=my-topic KAFKA_CONSUMER_GROUP_NAME=test pipenv run python KafkaConsumer.py

setup:
	pip list|(grep pipenv && echo pipenv already installed || pip install pipenv)
	pipenv install
