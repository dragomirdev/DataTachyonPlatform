# DataTachyonPlatform - Integration  Layer

## Introduction

The Integration Layer provides the capability to mediate which includes transformation, routing, and protocol conversion to transport service requests from the service requester to the correct service provider.

In Big Data, an enormous volume of data is used. Regarding data, we have two main challenges.
* The first challenge is how to collect large volume of data.
* The second challenge is to analyze the collected data. 

To overcome those challenges, there is a need for messaging system.

### Apache Kafka

Apache Kafka is a distributed publish-subscribe messaging system and a robust queue that can handle a high volume of data and enables you to pass messages from one end-point to another.
* Kafka is designed for distributed high throughput systems, built-in partitioning, replication and inherent fault-tolerance, which makes it a good fit for large-scale message processing applications.
* Kafka tends to work very well as a replacement for a more traditional message broker. 
* Kafka is suitable for both offline and online message consumption. 
* Kafka messages are persisted on the disk and replicated within the cluster to prevent data loss. 
* Kafka is built on top of the ZooKeeper synchronization service. 
* It integrates very well with Apache Nifi, Storm and Spark for real-time streaming data analysis.

### Benefits  of Apache NiFi
* Reliability − Kafka is distributed, partitioned, replicated and fault tolerance.

* Scalability − Kafka messaging system scales easily without down time..

* Durability − Kafka uses Distributed commit log which means messages persists on disk as fast as possible, hence it is durable..

* Performance − Kafka has high throughput for both publishing and subscribing messages. It maintains stable performance even many TB of messages are stored.

### Use Cases to use Kafka

* Metrics − Kafka is often used for operational monitoring data. This involves aggregating statistics from distributed applications to produce centralized feeds of operational data.

* Log Aggregation Solution − Kafka can be used across an organization to collect logs from multiple services and make them available in a standard format to multiple con-sumers.

* Stream Processing − Popular frameworks such as Storm and Spark Streaming read data from a topic, processes it, and write processed data to a new topic where it becomes available for users and applications. Kafka’s strong durability is also very useful in the context of stream processing.

### Need for Kafka

* Kafka is a unified platform for handling all the real-time data feeds. 
* Kafka supports low latency message delivery and gives guarantee for fault tolerance in the presence of machine failures. 
* It has the ability to handle a large number of diverse consumers. Kafka is very fast, performs 2 million writes/sec. 
* Kafka persists all data to the disk, which essentially means that all the writes go to the page cache of the OS (RAM). 
* This makes it very efficient to transfer data from page cache to a network socket.

### Apache Kafka Components

The following table describes the Kafka main components.

|Component|  Description |
|---|---|
| Topics | A stream of messages belonging to a particular category is called a topic. Data is stored in topics. Topics are split into partitions. For each topic, Kafka keeps a mini-mum of one partition. Each such partition contains messages in an immutable ordered sequence. A partition is implemented as a set of segment files of equal sizes. |
|Partition|Topics may have many partitions, so it can handle an arbitrary amount of data.|
|Partition offset|Each partitioned message has a unique sequence id called as offset.|
|Replicas of partition|Replicas are nothing but backups of a partition. Replicas are never read or write data. They are used to prevent data loss.|
|Brokers|Brokers are simple system responsible for maintaining the pub-lished data. Each broker may have zero or more partitions per topic. Assume, if there are N partitions in a topic and N number of brokers, each broker will have one partition. Assume if there are N partitions in a topic and more than N brokers (n + m), the first N broker will have one partition and the next M broker will not have any partition for that particular topic. Assume if there are N partitions in a topic and less than N brokers (n-m), each broker will have one or more partition sharing among them. This scenario is not recommended due to unequal load distri-bution among the broker.|
|Kafka Cluster|Kafka’s having more than one broker are called as Kafka cluster. A Kafka cluster can be expanded without downtime. These clusters are used to manage the persistence and replication of message data.|
|Producers|Producers are the publisher of messages to one or more Kafka topics. Producers send data to Kafka brokers. Every time a producer pub-lishes a message to a broker, the broker simply appends the message to the last segment file. Actually, the message will be appended to a partition. Producer can also send messages to a partition of their choice.|
|Consumers|Consumers read data from brokers. Consumers subscribes to one or more topics and consume published messages by pulling data from the brokers.|
|Leader| Leader is the node responsible for all reads and writes for the given partition. Every partition has one server acting as a leader.|
|Follower|Node which follows leader instructions are called as follower. If the leader fails, one of the follower will automatically become the new leader. A follower acts as normal consumer, pulls messages and up-dates its own data store.|

### Apache Kafka Architecture

The following diagram illustrates the main terminologies used in Kafka.

![Kafka-Architecture](/integrationlayer/kafka/images/kafka_fundamental.png)

In the above diagram, a topic is configured into three partitions. 
* Partition 1 has two offset factors 0 and 1. 
* Partition 2 has four offset factors 0, 1, 2, and 3. 
* Partition 3 has one offset factor 0. 
* The id of the replica is same as the id of the server that hosts it.
* Assume, if the replication factor of the topic is set to 3, then Kafka will create 3 identical replicas of each partition and place them in the cluster to make available for all its operations. 
* To balance a load in cluster, each broker stores one or more of those partitions.
* Multiple producers and consumers can publish and retrieve messages at the same time.


### Apache Kafka Ecosystem

The following diagram illustrates the Kafka Ecosystem.

![Kafka-Architecture](/integrationlayer/kafka/images/kafka_cluster_architecture.png)

The following table describes each of the Kafka Ecosystem components shown in the above diagram.

|Kafka Ecosystem Component|  Description |
|---|---|
|Broker|Kafka cluster typically consists of multiple brokers to maintain load balance. Kafka brokers are stateless, so they use ZooKeeper for maintaining their cluster state. One Kafka broker instance can handle hundreds of thousands of reads and writes per second and each bro-ker can handle TB of messages without performance impact. Kafka broker leader election can be done by ZooKeeper.|
|ZooKeeper|ZooKeeper is used for managing and coordinating Kafka broker. ZooKeeper service is mainly used to notify producer and consumer about the presence of any new broker in the Kafka system or failure of the broker in the Kafka system. As per the notification received by the Zookeeper regarding presence or failure of the broker then pro-ducer and consumer takes decision and starts coordinating their task with some other broker.|
|Producers|Producers push data to brokers. When the new broker is started, all the producers search it and automatically sends a message to that new broker. Kafka producer doesn’t wait for acknowledgements from the broker and sends messages as fast as the broker can handle.|
|Consumers|Since Kafka brokers are stateless, which means that the consumer has to maintain how many messages have been consumed by using partition offset. If the consumer acknowledges a particular message offset, it implies that the consumer has consumed all prior messages. The consumer issues an asynchronous pull request to the broker to have a buffer of bytes ready to consume. The consumers can rewind or skip to any point in a partition simply by supplying an offset value. Consumer offset value is notified by ZooKeeper.|



### Apache Nifi

* Apache NiFi is an open source software for automating and managing the flow of data between systems.
* It is a powerful and reliable system to process and distribute data.
* It provides a web-based User Interface for creating, monitoring, & controlling data flows.
* It has a highly configurable and modifiable data flow process that can modify data at runtime.
* It is easily extensible through the development of custom components.
* It allows you to do data ingestion to pull data into NiFi, from numerous data sources and create flow files
* It offers real-time control which helps you to manage the movement of data between any source & destination.
* It is used to visualize DataFlow at the enterprise level.
* It is designed to scale-out in clusters which offer guaranteed delivery of data
* It is used to visualize and Monitor performance, behavior in a flow bulletin which offers insight and inline documentation
* It helps you to listen, fetch, split, aggregate, route, transform and drag & drop Dataflow
* It provides connection processors for many data sources.

### Apache NiFi Architecture

NiFi executes within a JVM on a host operating system.

The primary components of NiFi on the JVM are shown by the following diagram:\
![Nifi-Architecture](/integrationlayer/nifi/images/nifi_architecture.png)

### DTP Data Ingestion Flow using Apache Nifi

#### Data Flow is shown using the following diagram:

![Create-DTP-Nifi-Uninstaller Jenkins](/integrationlayer/nifi/images/nifi_dataingestion_flow.png)

* An Remote SFTP Folder is setup to store the real time incoming files.

* Apache Nifi is configured to reading the above Remote SFTP Input Folder.

* It is then moved to the Distributed File System like Hadoop's Landing Folder.

* A backup of the files is stored in the Remote SFTP Backup Folder.

* In case of any Data Flow Transfer Error, those files are stored in the Remote SFTP Error Folders to recorrect and repush.

In Data Tachyon, Apachee Nifi is used to look for incoming data on Remote SFTP Folders, to perform the data ingestion from and push the data to the Distributed File System like Hadoop.

#### For DTP Nifi Setup using Jenkins goto: [DTP NiFi Setup  Process](/integrationlayer/nifi/README.md)

