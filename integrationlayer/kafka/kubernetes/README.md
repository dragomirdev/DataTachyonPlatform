# DataTachyonPlatform - Integration  Layer - Kafka Cluster with Kubernetes

## Introduction

Apache Kafka is an open-source distributed streaming platform which can deployed in a Cluster using the Kubernetes using Kafka Operator.

### Kafka-Operator
DTP uses the Banzai Cloud Kafka operator is a Kubernetes operator to automate provisioning, management, autoscaling and operations of Apache Kafka clusters deployed to K8s.

Some of the main features of the Kafka-operator are:

* The provisioning of secure and production ready Kafka clusters
* Fine grained broker configuration support
* Advanced and highly configurable External Access via LoadBalancers using Envoy
* Graceful Kafka cluster scaling and rebalancing
* Monitoring via Prometheus
* Encrypted communication using SSL
* Automatic reaction and self healing based on alerts (plugin system, with meaningful default alert plugins) using Cruise Control
* Graceful rolling upgrade
* Advanced topic and user management via CRD


The Integration Layer provides the capability to mediate which includes transformation, routing, and protocol conversion to transport service requests from the service requester to the correct service provider.

The DTP Integration Layer consists of the following Tools

* Apache Kafka
* Apache Nifi

### Apache Kafka

In Big Data, an enormous volume of data is used. Regarding data, we have two main challenges.
* The first challenge is how to collect large volume of data.
* The second challenge is to analyze the collected data. 

To overcome those challenges, there is a need for messaging system like Apache Kafka.

