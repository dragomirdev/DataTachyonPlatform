# DataTachyon Platform(DTP Server/VM) Common Configuration Setup

## DTP Server/VM Setup Instruction

The Common Scripts for the DTP Server Configurations can be found at
[PreInstallation-DTP-Server](/common/scripts/pre_installation.sh)

### Generate SSH Keys on each Server

ssh-keygen -t rsa

### Add the public keys to the authorized_keys in .ssh folder on each Server/VM

cat .ssh/id_rsa.pub >> .ssh/authorized_keys \
sudo chmod -R 700 .ssh \
sudo chmod -R 640 .ssh/authorized_keys

## Add the localhost keys to the known_hosts file in .ssh

ssh localhost

### Copy the public keys for each each Server/VM to the other Server/VMs in DTP

* Copying the public keys of the remote host/VM to the local .ssh/authorized_keys file.
* ssh-copy-id Bothways i.e. from JENKINS to TARGET HOSTS/VMS and also from TARGET VM to JENKINS HOSTS/VMS.
* This is also done for all the SPARK, HADOOP for hadoop & dtpuser users & in other Hosts/VMs for intercommunication.

ssh-copy-id <USER_NAME>@<HOST_NAME>

### Create dtpuser user for all Server/VMs in DTP

sudo groupadd hadoop \
sudo adduser --ingroup hadoop dtpuser \
password: <ENTER_PASSWORD> \
set default values for rest \
sudo usermod -aG sudo dtpuser

### Create hadoop user for all Hadoop and Spark Server/VMs in DTP

sudo groupadd hadoop \
sudo adduser --ingroup hadoop hadoop \
password: <ENTER_PASSWORD> \
set default values for rest \
sudo usermod -aG sudo hadoop

### Add exception to sudoers file for the user dtpuser before the DTP Installation using Jenkins as follows

Note: This is a manual step. \
sudo vi /etc/sudoers  
dtpuser ALL=(ALL) NOPASSWD: ALL

### Remove exception to sudoers file for the user dtpuser After the DTP Installation on the Server/VM as follows

Note: This is a manual step done. \
Remove the last line as shown below for the dtpuser entry.

sudo vi /etc/sudoers  
dtpuser ALL=(ALL) NOPASSWD: ALL

