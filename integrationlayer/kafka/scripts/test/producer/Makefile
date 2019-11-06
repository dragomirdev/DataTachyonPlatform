run:
	KAFKA_LISTENER=13.78.135.163:30795 KAFKA_TOPIC_NAME=my-topic pipenv run python KafkaProducer.py

setup:
	pip list|(grep pipenv && echo pipenv already installed || pip install pipenv)
	pipenv install
