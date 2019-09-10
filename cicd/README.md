**Continuous Integration & Continuous Deployment(CICD):**

**A) Introduction:**

**Continuous Integration(CI):**\
It is used integrate code into a shared repository used by developers. 
Each check-in is then verified by an automated build, allowing teams to detect problems early. 
By integrating regularly, you can detect errors quickly, and locate them more easily.

The DTP uses Jenkins a free, open-source, Java-based tool that gives you a lot of flexibility.

**Continuous Delivery (CD):**\
It is the ability to get changes of all types—including new features, configuration changes, bug fixes. 
This is achieve all this by ensuring our code is always in a deployable state, 
 even in the face of teams of thousands of developers making changes on a daily basis.

**B) Installation of DTP using CI/CD with Jenkins:**\
Using CI/CD with Jenkins, The following DTP software components are installed on the Target VM.
![DTP CICD Pipeline](/cicd/images/dtp-cicd-pipeline.png)

**Data Tachyon CI/CD Pipeline using Jenkins**
* Data Ingestion using Nifi from the Remote SFTP Folder to landing directory to HDFS.
* AI/Spark Packages form the Business Layer involving Data Cleansing & Data Preparation Stage. 
* The Features and Model Generation is done by the AI Software Packages like Tensorflow, Keras, Pytorch, FastAI, etc.
* Presentation Layer like  Elasticsearch, Logstash, Kibana  is used to Data Indexing & Data visualisation.

**C) Install Jenkins on JP-DTP-JENKINS-VM Ubuntu VM**

1. Login(ssh) to the JP-DTP-JENKINS-VM as the root user using the private keys of the Jenkins VM:\
      ssh azureadmin@cicd.southindia.cloudapp.azure.com  -i <local_ssh_keys_folder>/id_rsa

2. Install Java.\
   sudo apt update \
   sudo apt install openjdk-8-jdk 

3. Add the Jenkins Debian repository:
   Import the GPG keys of the Jenkins repository using the following wget command:\
   wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

   Add the Jenkins repository to the system\
   sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'   

4. Install Jenkins:\
   sudo apt update\
   sudo apt install jenkins

5. Jenkins service will automatically start after the installation process is complete. \
   This can be verify it by printing the service status: \
   sudo systemctl status jenkins

   You should see something similar to this:\

    `   ● jenkins.service - LSB: Start Jenkins at boot time
       Loaded: loaded (/etc/init.d/jenkins; generated)
       Active: active (exited) since Wed 2019-08-02 13:03:08 GMT; 2min 16s ago
           Docs: man:systemd-sysv-generator(8)
           Tasks: 0 (limit: 2319)
       CGroup: /system.slice/jenkins.service
       `



**D) Setting Up Jenkins  on JP-DTP-JENKINS-VM Ubuntu VM**

1. Open your browser, use the link, http://cicd.southindia.cloudapp.azure.com:8080 \
![Unlock Jenkins](/cicd/jenkins/images/unlock-jenkins.png)

2. Use the following command to print the initial Jenkins alphanumeric password password on your terminal: \
        cat /var/lib/jenkins/secrets/initialAdminPassword
   
3. Copy the password from your terminal, paste it into the Administrator password field and click Continue. \
![Customize Jenkins](/cicd/jenkins/images/customize-jenkins.png)

4. In next screen, the setup wizard will ask you whether you want to install suggested plugins or you want to select specific plugins. 
   Click on the Select Plugins to Install, and select the following plugins\
        Build Pipeline Plugin \
        Conditional Build Step \
        Credentials \
        Docker Pipeline \
        Github plugin \
        Pipeline \
        Publish Over SSH \
        SSH Agent Plugin \
        SSH plugin 
        
   and the installation process will start immediately \
        ![Getting Jenkins Started](/cicd/jenkins/images/jenkins-getting-started.png)   
        
5. Once the plugins are installed, you will be prompted to set up the first admin user. \
   Fill out all required information and click Save and Continue: \
        Username:      dtpadmin                                   \
        Password:      JPSpace2019$                               \
        Email address: dtpadmin@jpyramid.co.uk                    \
![Jenkins Create Admin User](/cicd/jenkins/images/jenkins-create-admin-user.png) 

6. The next page is used to set the URL for your Jenkins instance. \
   The field will be populated with an automatically generated URL.\
 ![Jenkins Instance Url](/cicd/jenkins/images/jenkins-instance-configuration.png)    

7. Confirm the URL by clicking on the Save and Finish button and the setup process will be completed.\
![Jenkins is Ready](/cicd/jenkins/images/jenkins-is-ready.png)  

8. Click on the Start using Jenkins button and you will be redirected to the Jenkins dashboard \
   logged in as the admin user you have created in one of the previous steps.
![Jenkins is Ready](/cicd/jenkins/images/jenkins-homepage.png) 
    Jenkins URL:  http://cicd.southindia.cloudapp.azure.com:8080


**E) Uninstall Jenkins on JP-DTP-JENKINS-VM Ubuntu VM**\

1. Stop Jenkins service first.

   sudo service jenkins stop

2. Remove Jenkins. \
   sudo apt-get remove --purge jenkins







 




