# CICD using Jenkins

**A) Install Jenkins on JP-DTP-JENKINS-VM Ubuntu VM**

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



**B) Setting Up Jenkins  on JP-DTP-JENKINS-VM Ubuntu VM**

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


**C) Add Credentails Page in Jenkins**

**Pre-Requisite**

a) Make sure the user say 'dtpuser' with which the Jenkins wants to login to a target VM \
   has got the DTPUser user created using the following scripts.
   *  Create a user named dtpuser user 
   sudo groupadd dtpuser \
   sudo adduser --ingroup dtpuser dtpuser \
   password: dtpuser
   * Set default values for rest of the options
   * Add DTP user to the sudoers file \
   sudo usermod -aG sudo dtpuser 
   
b) Add exception to sudoers file for the user dtpuser as follows:\
        sudo vi /etc/sudoers  \
        dtpuser ALL=(ALL) NOPASSWD: ALL
  
        save and exit


1. From Jenkins Home Page Click Credentials on the Left Side Panel.\
![Jenkins is Ready](/cicd/jenkins/images/credentials-page.png) 

2. Under Credentials click on Stores scoped to goto Jenkins --> Credentials --> System --> Global Credentials.

3. Click on Add Credentials and provide the user credentials for DTP User.\
![Jenkins is Ready](/cicd/jenkins/images/add-dtpuser-credentials.png)     

4. Once DTP User is Created it is shown in the Credentials page as follows:\
![Jenkins is Ready](/cicd/jenkins/images/add-credentials.png)   
   
 
 
 **D) Configure SSH Remote Hosts** 
 
 **Pre-Requisite**
 
 a) Make sure the Target VMs like JP-DTP-NIFI-VM, JP-DTP-ELK-VM , etc are created with the public/private keys.
 
 1. From Jenkins Home Page Click Manage Jenkins on the Left Side Panel.\
 
 2. Under Manage Plugins click on Configure System. \
 
 3. Goto SSH Remote hosts and Click on Add to add a Remote SSH Host.\

![Jenkins is Ready](/cicd/jenkins/images/configure_ssh_remote_hosts.png)     
 
 4. Once the Remote SSH Host click on Check Connection to test the connection is successful to the remote host as follows:\

![Jenkins is Ready](/cicd/jenkins/images/ssh_remote_connection_test.png)   
    