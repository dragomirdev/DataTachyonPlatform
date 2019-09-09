# CICD using Jenkins

[[_TOC_]]

#Install Jenkins on JP-DTP-JENKINS-VM Ubuntu VM

##Prerequisites:

a) Login(ssh) to the JP-DTP-JENKINS-VM as the root user using the private keys of the Jenkins VM 
   ssh azureadmin@cicd.southindia.cloudapp.azure.com  -i <local_ssh_keys_folder>/id_rsa

b) Install Java.
   sudo apt update
   sudo apt install openjdk-8-jdk

c) Add the Jenkins Debian repository:
   Import the GPG keys of the Jenkins repository using the following wget command:
   wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
   
   Add the Jenkins repository to the system
   sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'   

d) Install Jenkins:
   sudo apt update
   sudo apt install jenkins

e) Jenkins service will automatically start after the installation process is complete. 
   This can be verify it by printing the service status
   sudo systemctl status jenkins
   
   You should see something similar to this:
   
   ● jenkins.service - LSB: Start Jenkins at boot time
   Loaded: loaded (/etc/init.d/jenkins; generated)
   Active: active (exited) since Wed 2019-08-02 13:03:08 GMT; 2min 16s ago
       Docs: man:systemd-sysv-generator(8)
       Tasks: 0 (limit: 2319)
   CGroup: /system.slice/jenkins.service



**Setting Up Jenkins  on JP-DTP-JENKINS-VM Ubuntu VM**

a) Open your browser, use the link, http://cicd.southindia.cloudapp.azure.com:8080
   ![Unlock Jenkins](/attachments/images/unlock-jenkins.png)
   
 
  