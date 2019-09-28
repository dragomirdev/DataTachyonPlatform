# DTP-Presentation Layer

## Introduction

The Presentation Layer provides the visual graphical output by reading the processed and model data generated using AI Techniques and provies insights using different metrics to GUI Layer by converting the data into useful information.

DTP uses the following Software Components for the Presentation Layer

* ElasticSearch LogStash Kibana (ELK) Stack
* Liferay Portal
* Jupyter Notebook
* Hue Web User Interface

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

![Liferay-Architecture](/presentationlayer/Liferay/images/logos/liferay-architecture.png)

* Liferay is very flexible in terms of accessing external
systems as well as being accessed by all sorts of external
"clients" from regular desktops to third party apps going
through mobile apps and browsers.
* Liferay is compliant with terms such as SOA, WOA even since before the terms existed.
* Liferay includes many transversal frameworks that are
used inside it but also made available for applications
built on top of it.

#### For DTP Liferay Setup using Jenkins goto: [Liferay Setup Process](/presentationlayer/Liferay/README.md)

### Jupyter NoteBook

* The Jupyter Notebook is an Useful tool for interactively developing and presenting data science projects.
* As a server-client application, the Jupyter Notebook App allows you to edit and run your notebooks via a web browser.
* The application can be executed on a PC without Internet access, or it can be installed on a remote server, where you can access it through the Internet.
* Its two main components are the kernels and a dashboard.

#### Kernel

![Native Kernel](/presentationlayer/JupyterNotebook/images/ipy_kernel_and_terminal.png)

* A kernel is a program that runs and introspects the user’s code. The Jupyter Notebook App has a kernel for Python code, but there are also kernels available for other programming languages.

#### Notebook Dashboard

![Native Kernel](/presentationlayer/JupyterNotebook/images/notebook_components.png)

* The dashboard of the application not only shows you the notebook documents that you have made and can reopen but can also be used to manage the kernels: you can which ones are running and shut them down if necessary.

* The Notebook frontend does something extra. In addition to running your code, it stores code and output, together with markdown notes, in an editable document called a notebook. When you save it, this is sent from your browser to the notebook server, which saves it on disk as a JSON file with a .ipynb extension.

* The notebook server, not the kernel, is responsible for saving and loading notebooks, so you can edit notebooks even if you don’t have the kernel for that language—you just won’t be able to run code. The kernel doesn’t know anything about the notebook document: it just gets sent cells of code to execute when the user runs them.

#### For DTP Jupyter NoteBook Setup using Jenkins goto: [Jupyter NoteBook Setup Process](/presentationlayer/JupyterNotebook/README.md)

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
