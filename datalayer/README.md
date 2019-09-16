# DTP - Data Layer

## Introduction

The DTP Data layer consists of the following:

* Hadoop Distributed File System (HDFS)
* Hive
* Spark

### Hadoop Distributed File System (HDFS)

### Introduction to HDFS

Hadoop is a framework that allows for the distributed processing of large datasets across clusters of computers using simple programming models.

It is inspired by a technical document published by Google.

The four key characteristics of Hadoop are:

#### Reliable

It is reliable as it stores copies of the data on different machines and is resistant to hardware failure.

#### Scalable

It is easily scalable both, horizontally and vertically. A few extra nodes help in scaling up the framework.

#### Flexible

It is flexible and you can store as much structured and unstructured data as you need to and decide to use them later.

#### Economical

Its systems are highly economical as ordinary computers can be used for data processing.

#### Advantages of Hadoop over Traditional Database system

* Using Hadoop, the program goes to the data. It initially distributes the data to multiple systems and later runs the computation wherever the data is located.

* Hadoop works better when we use large data size. It can process and store a large amount of data efficiently and effectively.

* Hadoop can process and store a variety of data, whether it is structured or unstructured.

* HDFS is a storage layer for Hadoop.

* HDFS is suitable for distributed storage and processing, that is, while the data is being stored, it first gets distributed and then it is processed.

* HDFS provides Streaming access to file system data.

* HDFS provides file permission and authentication.

* HDFS uses a command line interface to interact with Hadoop.

### HDFS Architecture

![HDFS Architecture](/datalayer/hadoop/images/hdfs_architecture.png)

* HDFS has a master/slave architecture.
* An HDFS cluster consists of a one **NameNode**, a master server that manages the file system namespace and regulates access to files by clients.
* In addition, there are a number of **DataNodes**, usually one per node in the cluster, which manage storage attached to the nodes that they run on.
* HDFS exposes a file system namespace and allows user data to be stored in files.
* Internally, a file is split into one or more blocks and these blocks are stored in a set of DataNodes.
* The NameNode executes file system namespace operations like opening, closing, and renaming files and directories.
* It also determines the mapping of blocks to DataNodes. The DataNodes are responsible for serving read and write requests from the file system’s clients.
* The DataNodes also perform block creation, deletion, and replication upon instruction from the NameNode.

#### NameNode Features

* It is the master daemon that maintains and manages the DataNodes (slave nodes).
* It records the metadata of all the blocks stored in the cluster, e.g. location of blocks stored, size of the files, permissions, hierarchy, etc.
* It records each and every change that takes place to the file system metadata.
* If a file is deleted in HDFS, the NameNode will immediately record this in the EditLog.
* It regularly receives a Heartbeat and a block report from all the DataNodes in the cluster to ensure that the DataNodes are live.
* It keeps a record of all the blocks in the HDFS and DataNode in which they are stored.
* It has high availability and federation features which I will discuss in HDFS architecture in detail.

#### DataNode Features

* It is the slave daemon which run on each slave machine
* The actual data is stored on DataNodes
* It is responsible for serving read and write requests from the clients
* It is also responsible for creating blocks, deleting blocks and replicating the same based on the decisions taken by the NameNode
* It sends heartbeats to the NameNode periodically to report the overall health of HDFS, by default, this frequency is set to 3 seconds.

#### For DTP HDFS Setup using Jenkins goto: [DTP HDFS Setup  Process](/datalayer/hadoop/README.md)
