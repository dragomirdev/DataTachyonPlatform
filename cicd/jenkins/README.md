# CICD using Jenkins




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
    