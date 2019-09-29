# DTP - Data Layer

## Introduction

The DTP Data layer consists of the following:

* Apache Hadoop Distributed File System (HDFS)
* Apache Hive
* Apache Spark
* Hue

## Apache Hadoop Distributed File System (HDFS)

### Introduction to HDFS

Hadoop is a framework that allows for the distributed processing of large datasets across clusters of computers using simple programming models & is inspired by a technical document published by Google.

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

#### HDFS Architecture

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

### DTP HDFS Setup

![DTP-HDFS-Setup](/datalayer/hadoop/images/dtp-hdfs-setup.png)

#### For DTP HDFS Setup using Jenkins goto: [DTP HDFS Setup  Process](/datalayer/hadoop/README.md)

## Apache Hive

### Introduction to Hive

Apache Hive is an open source data processing software tool on Hadoop. 
It is a database tool for querying and analyzing large datasets stored in Hadoop.

#### Advantages of Hive

* Schema flexibility and evolution.
* Tables can be portioned and bucketed.
* Apache Hive tables are defined directly in the HDFS.
* JDBC/ODBC drivers are available.
* It provides data summarization, query, and analysis in much easier manner.
* It supports external tables which make it possible to process data without actually storing in HDFS.
* It fits the low-level interface requirement of Hadoop perfectly.
* It also supports partitioning of data at the level of tables to improve performance.
* It has a rule based optimizer for optimizing logical plans.
* It is scalable, familiar, and extensible.
* Using HiveQL doesn’t require any knowledge of programming language, Knowledge of basic SQL query is enough.
* The users can easily process structured data in Hadoop using Hive.
Querying in Hive is very simple as it is similar to SQL.
* The users can also run Ad-hoc queries for the data analysis using Hive.

### Hive Architecture

![Hive Architecture](/datalayer/hive/images/hive_architecture.png)

The main components of Apache Hive are

#### Metastore

* Hive stores the metadata for each of the tables like their schema and includes the partition metadata which helps the driver to track the progress of various data sets distributed over the cluster. Hive metadata helps the driver to keep a track of the highly crucial data. Backup server regularly replicates the data which it can retrieve in case of data loss.

#### Driver

* The Driver acts like a controller which receives the HiveQL statements and starts the execution of the statement by creating sessions. It monitors the life cycle and progress of the execution and stores the necessary metadata generated during the execution of a HiveQL statement and acts as a collection point of data or query result obtained after the Reduce operation.

#### Compiler

* The Compiler performs the compilation of the HiveQL query and converts the query to an execution plan which contains the tasks and also contains steps needed to be performed by the MapReduce to get the output as translated by the query.

#### Optimizer

* It performs various transformations on the execution plan to provide optimized It performs various transformations on the execution plan to provide optimized Directed Acyclic Graph (DAG) obtained by the compiler.

#### Executor

* Once compilation and optimization complete, the executor executes the tasks. Executor takes care of pipelining the tasks.

#### Command-line interface (CLI)), UI, and Thrift Server

* CLI (command-line interface) provides a user interface for an external user to interact with Hive. Thrift server in Hive allows external clients to interact with Hive over a network, similar to the JDBC or ODBC protocols.

#### Hive Shell

* It is the command line interface which is used to interact with the Hive and to issue  commands or queries in HiveQL.

* It has two modes of run namely Non-Interactive mode and Interactive mode. Non-interactive mode is run with -f option.

### DTP Hive Setup

![DTP-Hive-Setup](/datalayer/hive/images/dtp_hive_setup.png)

#### For DTP Hive Setup using Jenkins goto: [DTP Hive Setup  Process](/datalayer/hive/README.md)

## Apache Spark

### Introduction to Spark

Apache Spark is an open-source general-purpose & lightning fast cluster computing framework for real-time processing and integrates with all the Big data tools like Apache Hadoop.

#### Advantages of Spark

* It process the data swiftly using Parallel Processing of the data over the cluster.
* It is Fault Tolerant & is able to recover lost data easily in case of any worker node failure.
* It improves the performance by an order of magnitudes by keeping the data In-Memory Computation
* Reusability
* It limits how much work it has to do using Lazy Evaluation and only after an action triggers all the changes or the computation is performed.
* It performs Coarse Grained Operation by applying it to the whole dataset not on the single element in the data set.
* It supports multiple languages.

### Spark Architecture

![Spark Architecture](/datalayer/spark/images/spark_architecture.png)

* The SparkContext connects to the cluster manager which allocates resources across applications.
* Once the SparkContext is connected to the cluster manager, Spark acquires executors on nodes in the cluster, which are processes that run computations and store data for the application.
* The application code is then sent to the executors.
* SparkContext then sends tasks to the executors to run.

### DTP Spark Setup

![DTP-Spark-Setup](/datalayer/spark/images/dtp_spark_cluster_setup.png)

#### For DTP Spark Setup using Jenkins goto: [DTP Spark Setup  Process](/datalayer/spark/README.md)

### Hue

* Hadoop Hue is an open source user interface for accessing Hadoop components.
* Hue assists Users to use Web Gui to access Hadoop ecosystem if they do not wish to use command line interface.
* The user can access Hue using the web browser and greatly improves the productivity of Hadoop users.
* This is developed by the Cloudera and is an open source project.
* Using Hue, the user can interact with HDFS, Hive Software Components.

#### Features of Hue

Hue provides the following listed features which makes it widely accepted tool for Hadoop Users.

![Hue-Gui](/datalayer/hue/images/hue_gui.png)

* Hadoop API Access
* Presence of HDFS File Browser
* Browser and Job Designer
* User Admin Interface
* Editor for Hive Query
* Editor for Pig Query
* Hadoop Shell Access
* Workflows can access Oozie Interface
* SOLR searches can get a separate interface

#### Hue Components

![Hue-Components](/datalayer/hue/images/hue_components.png)

##### HDFS Browser

![Hue-Hdfs-Browser](/datalayer/hue/images/hue_hdfs_browser.png)

* When working with Hadoop Ecosystem one of the most important factors is the ability to access the HDFS Browser through which user can interact with the HDFS files in an interactive manner.
* Hue provides such HDFS interface through which all required operations can be performed on HDFS.
* Hue provides alternate way of accessing Hadoop Components using Web Interface instead of command line interface.
* Login to Hue, click on the “File Browser” that is present in the top-right position.
* A file browser will be opened through this link. Following image shows this interface. For the current or default path, it will enlist all of the files along with file properties.
* The user can even either delete, download or upload new files using the HDFS Browser.

##### Job Browser

![Hue-Job-Browser](/datalayer/hue/images/hue_job_browser.png)

* Hadoop ecosystems consist of many jobs and sometimes developers may need to know that which job is currently running on the Hadoop cluster and which job has been successfully completed and which has errors.
* Through Job browser, you can access all of the job-related information right from inside the browser.
* Job Browser in Hue is used to enlist the number of jobs and their status.

##### Hive Query Editor

![Hue-Job-Browser](/datalayer/hue/images/hue_hive_query_editor.png)

* Hive query editor allows us to write SQL Hive queries right inside the editor and the result can also be shown in the editor.
* Hue editor makes the querying data easier and quicker.
* The user can write SQL like queries and execution of these queries can produce MapReduce job by processing data and the job browser can be checked from the browser even when it is in running state.
* Query result can be shown in the browser.

A bar chart result is shown below:

![Hue-Bar-Chart-Query-Editor](/datalayer/hue/images/hue_query_editor_chart.png)

* Such charts that are produced as the result of any query can easily be saved to the disk or can be exported to any other file easily. 
* Not only bar chart eve you can produce many other types of charts like a pie chart, line chart and others.

##### Database Browsers

![Hue-DB-Browser](/datalayer/hue/images/hue_db_browser.png)

* All of the available datastore tables can be displayed, exported and imported through Database browser.
* Following image shows the database tables. When you will click on any particular table then you can also access the desired information of that table.
* Right from within the user interface you can view the data and access it.
* Table data can be visualized and checked from there and you can check the column of any particular table along with its names.

#### For DTP Hue Setup using Jenkins goto: [DTP Hue Setup Process](/datalayer/hue/README.md)
