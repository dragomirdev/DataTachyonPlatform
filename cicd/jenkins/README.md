# CICD using Jenkins

## Configure Jenkins

## Setting Up Jenkins  on JP-DTP-JENKINS-VM Ubuntu VM/Server Node

1. Open your browser, use the link, http://hostname:8080 \
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
        Password:      ******                               \
        Email address: admin@test       .co.uk                    \
![Jenkins Create Admin User](/cicd/jenkins/images/jenkins-create-admin-user.png)

6. The next page is used to set the URL for your Jenkins instance. \
   The field will be populated with an automatically generated URL.\
 ![Jenkins Instance Url](/cicd/jenkins/images/jenkins-instance-configuration.png) 

7. Confirm the URL by clicking on the Save and Finish button and the setup process will be completed.\
![Jenkins is Ready](/cicd/jenkins/images/jenkins-is-ready.png)  

8. Click on the Start using Jenkins button and you will be redirected to the Jenkins dashboard \
   logged in as the admin user you have created in one of the previous steps.
![Jenkins is Ready](/cicd/jenkins/images/jenkins-homepage.png) 
    Jenkins URL:  http://hostname:8080

## Add Credentails Page in Jenkins

This step enables the jenkins to connect using a user credentials which is configured as follows.

### Pre-Requisite Steps

1. Make sure the user say 'dtpuser' with which the Jenkins wants to login to a target VM has got the DTPUser user created using the following scripts.

2. Create a user named dtpuser user\
   sudo groupadd dtpuser \
   sudo adduser --ingroup dtpuser dtpuser \
   password: dtpuser
3. Set default values for rest of the options

4. Add DTP user to the sudoers file \
   sudo usermod -aG sudo dtpuser

5. Add exception to sudoers file for the user dtpuser as follows:\
        sudo vi /etc/sudoers  \
        dtpuser ALL=(ALL) NOPASSWD: ALL
  
6. Save and exit the file /etc/sudoers  

### Configure Credentials

1. From Jenkins Home Page Click Credentials on the Left Side Panel.
![Jenkins is Ready](/cicd/jenkins/images/credentials-page.png) 

2. Under Credentials click on Stores scoped to goto Jenkins --> Credentials --> System --> Global Credentials.

3. Click on Add Credentials and provide the user credentials for DTP User.\
![Jenkins is Ready](/cicd/jenkins/images/add-dtpuser-credentials.png)

4. Once DTP User is Created it is shown in the Credentials page as follows:\
![Add Jenkins Credentials](/cicd/jenkins/images/add-credentials.png)

### Configure Publish over SSH

#### Pre-Requisite

  Make sure the Target VMs like JP-DTP-NIFI-VM, JP-DTP-ELK-VM , etc are created with the public/private keys.

#### Steps for configure Publish over SSH

 1. From Jenkins Home Page Click Manage Jenkins on the Left Side Panel.\

 2. Under Manage Plugins click on Configure System. \

 3. Goto Publish over ssh and Click on Add to add a Remote SSH Host.\
         ![Jenkins is Ready](/cicd/jenkins/images/configure_publish_over_remote_connection.png)

 4. Once the Publish over remote ssh is done, Check Connection to test the connection is successful to the remote host as follows:\
         ![Jenkins is Ready](/cicd/jenkins/images/publish_over_remote_connection_test.png)
