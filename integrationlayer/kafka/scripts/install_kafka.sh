#!/bin/bash

# sudo apt -y update && sudo apt -y upgrade
# sudo apt -y install openjdk-8-jdk zip unzip net-tools curl
# Current default time zone:
# sudo timedatectl set-timezone Europe/London
# Add Kafka User
# sudo useradd kafka -m
# sudo passwd kafka
# sudo adduser kafka sudo
# sudo usermod -aG sudo kafka

# Login as kafka User
sudo su - kafka

# Download Link for the Kafka binaries:
# curl -L -O  "https://www.apache.org/dist/kafka/2.3.0/kafka_2.12-2.3.0.tgz"

# Running as kafka User
sudo mkdir -p /datadrive/kafka/logs/
sudo chmod -R 775 /datadrive/
sudo chown -R kafka:kafka /datadrive/

sudo apt -y install  python3-pip python3-dev
sudo wget https://bootstrap.pypa.io/get-pip.py
sudo python3.6 get-pip.py
sudo pip3 install -U setuptools pip
sudo pip3 install kafka-python

tar -xvzf kafka_2.12-2.3.0.tgz
sudo chmod -R 775 kafka_2.12-2.3.0
sudo chown -R kafka:kafka kafka_2.12-2.3.0
sudo mv kafka_2.12-2.3.0/ kafka
sudo mv kafka /opt/

cd /opt/
sed -i -e "s/localhost/$HOSTNAME/g" /opt/kafka/config/server.properties
echo listeners=PLAINTEXT://$HOSTNAME:9092 >> /opt/kafka/config/server.properties
echo  advertised.listeners=PLAINTEXT://$HOSTNAME:9092 >> /opt/kafka/config/server.properties
sed -i -e "s/log.dirs/#log.dirs/g" /opt/kafka/config/server.properties
echo log.dirs=/datadrive/kafka/logs >> /opt/kafka/config/server.properties
#echo delete.topic.enable = true >> /opt/kafka/config/server.properties


#Move the bash files to /opt directory
sudo mv /home/kafka/runZookeeper.sh /opt/kafka/
sudo mv /home/kafka/runKafka.sh /opt/kafka/
sudo mv /home/kafka/createDtpTopic.sh /opt/
sudo mv /home/kafka/producer_testmsg.sh /opt/
sudo mv /home/kafka/consumer_testmsg.sh /opt/

# Set Kafka User Permissions
sudo chmod -R 775 /opt/*.sh
sudo chown -R kafka:kafka /opt/*.sh
sudo chmod -R 775 /opt/kafka/
sudo chown -R kafka:kafka /opt/kafka/

# Set up Startup Services
sudo mv /home/kafka/zookeeper.service /etc/systemd/system
sudo mv /home/kafka/kafka.service /etc/systemd/system
sudo chmod 755 /etc/systemd/system/zookeeper.service 
sudo chmod 755 /etc/systemd/system/kafka.service 
sudo systemctl daemon-reload
sudo systemctl start zookeeper
sudo systemctl status kafka
sudo systemctl enable zookeeper
sudo systemctl enable kafka

# Install KafkaT
# KafkaT is a tool to view details about your Kafka cluster and
# perform certain administrative tasks from the command line
sudo apt -y install ruby ruby-dev build-essential
sudo gem -y install kafkat
sudo mv /home/kafka/.kafkatcfg /home/kafka/
kafkat partitions
