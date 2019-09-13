# DataTachyonPlatform - Integration  Layer

## Introduction

The Integration Layer provides the capability to mediate which includes transformation, routing, and protocol conversion to transport service requests from the service requester to the correct service provider.

In Data Tachyon, Apachee Nifi is used to look for incoming data on Remote SFTP Folders, to perform the data ingestion from and push the data to the Distributed File System like Hadoop.

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
