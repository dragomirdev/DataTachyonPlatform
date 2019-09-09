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

### Integration

The Integration Layer enables the connectivity with the back-end systems like RDBMS, IOT, Cloud Databases and any other current or legacy data sources.

### Data

The Data Layer is used to store any data, clean and enrich the datasets coming from the Integration Layer and provide backup capabilities.

### Business

The Business Layer is used to apply business logic to the datasets and create new data insights using Artificial Intelligence with Real-Time and Batch-Type systems.

### Presentation

The Presentation Layer is used to visualise results and provide new data insights that are coming from the Business Layer.
Visualisations can be expressed in a traditional 2D/3D format or 3D in a Virtual Reality format.

## Software Layers

Each Architectural Layer has a set of Open Source packages which include:

### Integration

NiFi

Spark

Kafka

### Data

Hadoop

Spark

### Business

Keras

Tensorflow

PyTorch

Numpy

Scipy

SciKit-Learn

Pandas

### Presentation

Kibana/Logstash/ElasticSearch

GoDot

## Software Configuration

The main DTP software configuration covering all layers:

![alt text](https://github.com/dragomirdev/DataTachyonPlatform/blob/dev/documentation/dtp/DTP-1.3-Tools-Architecture.jpeg)

## Development Team and Business Value


![alt text](https://github.com/dragomirdev/DataTachyonPlatform/blob/dev/documentation/dtp/DTP-Images.001.jpeg)

![alt text](https://github.com/dragomirdev/DataTachyonPlatform/blob/dev/documentation/dtp/DTP-Images.002.jpeg)
