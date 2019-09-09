**Continuous Integration & Continuous Deployment(CICD):**

**Continuous Integration(CI):**
It is used integrate code into a shared repository used by developers. 
Each check-in is then verified by an automated build, allowing teams to detect problems early. 
By integrating regularly, you can detect errors quickly, and locate them more easily.

The DTP uses Jenkins a free, open-source, Java-based tool that gives you a lot of flexibility.

**Continuous Delivery (CD):**
It is the ability to get changes of all types—including new features, configuration changes, bug fixes. 
This is achieve all this by ensuring our code is always in a deployable state, 
 even in the face of teams of thousands of developers making changes on a daily basis.

**Installation of DTP using CI/CD with Jenkins:**
Using CI/CD with Jenkins, The following DTP software components are installed on the Target VM.
       ![DTP CICD Pipeline](/cicd/images/dtp-cicd-pipeline.png)
* Data Ingestion using Nifi from the Remote SFTP Folder to landing directory to HDFS.
* AI/Spark Packages form the Business Layer involving Data Cleansing & Data Preparation Stage. 
* Presentation Layer like  Elasticsearch, Logstash, Kibana.






 




