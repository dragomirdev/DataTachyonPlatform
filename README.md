# DataTachyonPlatform

## Introduction

Data Tachyon Platform (DTP) is a software solution that provides a layered architecture for the delivery of end-to-end enterprise software projects with a focus on Big-Data AI Analytics solutions.

## DTP Types

There are 3 types of DTP that can be deployed in an organisation i.e.

#### On-Premise

For organisations that have sensitive data where they would like to keep it on-premise, DTP can be installed directly on servers of their choice using any Linux-based OS (in our case Ubuntu).

#### Hybrid

Organisations that would like to do the majority of pre-processing on-premise and sending just a limited dataset to the Cloud then a Hybrid solution can be installed.

#### Cloud

Organisations that have a Cloud strategy in place can deploy DTP in MS-AZURE, Google, AWS or IBM Cloud environments.


## Architectural Layers

The DTP is divided into 4 architectural layers to make the management of software and data workflows easier.

### Integration Layer

The Integration Layer enables the connectivity with the back-end systems like RDBMS, IOT, Cloud Databases and any other current or legacy data sources.

### Data Layer

The Data Layer is used to store any data, clean and enrich the datasets coming from the Integration Layer and provide backup capabilities.

### Business Layer

The Business Layer is used to apply business logic to the datasets and create new data insights using Artificial Intelligence with Real-Time and Batch-Type systems.

### Presentation Layer

The Presentation Layer is used to visualise results and provide new data insights that are coming from the Business Layer.
Visualisations can be expressed in a traditional 2D/3D format or 3D in a Virtual Reality format.

## Software Layers

Each Architectural Layer has a set of Open Source packages which include:

### Integration Layer Software Tools

* NiFi
* Spark

### Data Layer Software Tools

* Hadoop
* Spark
* Hive
* Hue

### Business Layer Software Packages

* Keras
* Tensorflow
* Fast-AI
* PyTorch
* Numpy
* Scipy
* SciKit-Learn
* Xgboost
* Gensim
* Pandas

### Presentation Layer Software Tools

* ElasticSearch
* Logstash
* Kibana
* GoDot

### Continuous Integration / Continuous Delivery Tool

* Jenkins

## Software Dataflow

The DTP enables a structured dataflow from each layer in order to provide an easier transition from data ingestion to data processing and visualisation as shown below

![DTP DataFlow](https://github.com/dragomirdev/DataTachyonPlatform/blob/dev/documentation/dtp/DTP-1.3-DataFlow.png)

## Software Configuration

The main DTP software configuration covering all layers:

![DTP Architecture](https://github.com/dragomirdev/DataTachyonPlatform/blob/dev/documentation/dtp/DTP-1.3-Tools-Architecture.jpg)

# DTP Installation Process 

## DTP Server Initial Setup Process

Before Installing the DTP Software Tools on the given Server/VM, there are some Pre Installation Steps needed.

For further information go to [DTP Server Pre Installation Steps](/common/Readme.md)

## Continuous Integration/Continuous Delivery

CI/CD is the main DTP component that is used for automated installation of all software packages.

The installation process is co-ordinated with the Jenkins tool.

### Jenkins Installation

To install Jenkins please go to [Jenkins Installation Process](/cicd/README.md)

## Integration Layer Installation

### NiFi Installation

To install NiFi please go to [NiFi Installation Process](/integrationlayer/README.md)

## Data Layer Installation

### Hadoop Installation

To install Hadoop please go to [Hadoop Installation Process](/datalayer/hadoop/README.md)

### Spark Installation

To install Spark please go to [Spark Installation Process](/datalayer/spark/README.md)

### Hive Installation

To install Hive please go to [Hive Installation Process](/datalayer/hive/README.md)

### Hue Installation

To install Hue please go to [Hue Installation Process](/presentationlayer/README.md)

## Business Layer Installation

### Tensorflow, Keras, Pytorch, Fast-AI Installation

To install Business Layer packages like Tensorflow, Keras, Pytorch, Fast-AI, etc please go to [Deep Learning Installation Process](/businesslayer/README.md)

### Numpy, Scipy, Scikit-Learn, Pandas Installation

To install Business Layer packages like Numpy, Scipy, Scikit-Learn, Pandas, etc please go to [Machine Learning Installation Process](/businesslayer/README.md)

## Presentation Layer Installation

### ElasticSearch/LogStash/Kibana - ELK Installation

To install ELK please go to [ELK Installation Process](/presentationlayer/README.md)

### Liferay Portal Installation

To install Liferay Portal please go to [Liferay Portal Installation Process](/presentationlayer/README.md)

### Jupyter NoteBook Installation

To install Jupyter NoteBook please go to [Jupyter NoteBook Installation Process](/presentationlayer/README.md)

## DataTachyonPlatform - Security

To install Security for DTP-Services please go to [DTP-Security](/common/security/README.md)




