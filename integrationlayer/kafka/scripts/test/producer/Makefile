run:
	KAFKA_LISTENER=13.78.135.163:19090,13.78.135.163:19091,13.78.135.163:19092 KAFKA_TOPIC_NAME=my-topic pipenv run python KafkaProducer.py

setup:
	pip list|(grep pipenv && echo pipenv already installed || sudo pip install pipenv)
	pipenv install
