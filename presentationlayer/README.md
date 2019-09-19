# DTP-Presentation Layer

## Introduction

The Presentation Layer provides the visual graphical output by reading the processed and model data generated using AI Techniques and provies insights using different metrics to GUI Layer by converting the data into useful information.

### ElasticSearch LogStash Kibana (ELK) Stack

* With the increase in IT infrastructures needed to run a project, log analytics platforms is also increasing rapidly.
* Organization irrespective of their size, generates a huge amount data on daily basis.
* Logs are one of the most important and often-neglected sources of information.
* Each log file contains invaluable pieces of information which are mostly unstructured and makes no sense.
* Careful and detailed analysis of this log data, an organization can prepare to both opportunities as well as threats surrounding it.
* Thats where the log analysis tools like the ELK Stack come in handy as it fulfills a need in the log management and analytics space.
* It is a powerful collection of three open source tools: Elasticsearch, Logstash, and Kibana.
* ELK Stack or Elastic Stack is a complete log analysis solution which helps in **deep searching, analyzing and visualizing the log**  
  generated from different machines.
* Elastic Search is a robust search and analytics tool that stores data in a document oriented data store.

#### Elasticsearch

* Elasticsearch is an open source NoSQL database, full-text search and analysis engine.
* It is based on the Apache Lucene search engine and is built with RESTful APIs.
* It provides advanced queries to perform detailed analysis and stores all the data centrally for quick search of the documents.

#### Logstash

* Logstash is a log aggregator that collects data from various input sources, executes different transformations and enhancements and then ships the data to various supported output destinations.

#### Kibana

Kibana is a visualization layer that works on top of Elasticsearch, providing users with the ability to analyze and visualize the data.

#### ELK Stack Architecture

![ELK-Architecture](/presentationlayer/ElasticSearch_Kibana_Logstash/images/elk_stack.png)

* The architecture of ELK Stack as shown above depicts the proper order of log flow within ELK.
* The logs generated from various sources are collected and processed by Logstash, based on the provided filter criteria.
* Logstash then pipes those logs to Elasticsearch which then analyzes and searches the data.
* Finally, using Kibana, the logs are visualized and managed as per the requirements.

#### For DTP ELK Setup using Jenkins goto: [ELK Setup Process](/presentationlayer/ElasticSearch_Kibana_Logstash/README.md)

### Liferay

* Liferay is implemented portlet technology and it exposed as Open Source and follows the JSR 168 and JSR 286 Compliants.
* Liferay is very good open source for portlet technology have very good working group and community.
* Portlet technology is similar to servlet technology but portlet is small part of dynamic content in web page.
* In normal web application when we send request then server serve the response to the client or browser. Here entire page will be served by one response.
* Coming to portlet technology in one web page there may be many portlets and each portlet have its own request and response.
* Each portlet can send request and get the response from server then the response belongs to only the portlet which send the request.
* Liferay Community Edition is available to public and anybody can get source code and then can add or customize.

#### Features of Liferay

* Liferay is ready to use web application
* Liferay have many portlet to full fill dynamic web application functionality
* Very Good Enterprise Web Content Management System
* Sites, Organization and User Groups
* Collaboration (Blogs, Wikis and Forums)
* Service Oriented Architecture Support.
* Dynamic Look and Feel from Themes
* Changing page layouts
* Good Portal Administration User Interface.
* Roles and Permission System
* Easy Customization and Development
* Support Many Integrations
* Liferay Market Place.

#### Liferay-Architecture

![Liferay-Architecture](/presentationlayer/Liferay/images/liferay-architecture.png)

* Liferay is very flexible in terms of accessing external
systems as well as being accessed by all sorts of external
"clients" from regular desktops to third party apps going
through mobile apps and browsers.
* Liferay is compliant with terms such as SOA, WOA even since before the terms existed.
* Liferay includes many transversal frameworks that are
used inside it but also made available for applications
built on top of it.

#### For DTP Liferay Setup using Jenkins goto: [ELK Setup Process](/presentationlayer/Liferay/README.md)
