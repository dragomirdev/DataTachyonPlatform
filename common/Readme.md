# DataTachyon Platform(DTP Server/VM) Common Configuration Setup

## Introduction

* The DTP Server Setup needs to be done on all DTP Servers Hosts/VMs for **dtpuser** & **hadoop** users to allow inter node communication.

* The Common Scripts for the DTP Server Configurations can be found at [DTP-Server-Setup](/common/scripts/pre_installation.sh)

## DTP Server/VM Setup Instruction

The DTP Server Setup includes the following Steps:

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

The following instructions needs to be done for both **dtpuser** & **hadoop** users

### Generate SSH Keys on each Server

ssh-keygen -t rsa

### Add the public keys to the authorized_keys in .ssh folder on each Server/VM

cat .ssh/id_rsa.pub >> .ssh/authorized_keys \
sudo chmod -R 700 .ssh \
sudo chmod -R 640 .ssh/authorized_keys

## Add the localhost info to the known_hosts file in .ssh

ssh localhost

### Copy the public keys for each each Server/VM to the other Server/VMs in DTP

* Copying the public keys of the remote host/VM to the local .ssh/authorized_keys file.
* ssh-copy-id Bothways i.e. from JENKINS to TARGET HOSTS/VMS and also from TARGET VM to JENKINS HOSTS/VMS.

ssh-copy-id <USER_NAME>@<HOST_NAME>

### Add exception to sudoers file for the user dtpuser before the DTP Installation using Jenkins as follows

Note: This is a manual step. \
sudo vi /etc/sudoers  
dtpuser ALL=(ALL) NOPASSWD: ALL
hadoop ALL=(ALL) NOPASSWD: ALL

### Note: Remove exception to sudoers file for the user dtpuser After the DTP Installation on the Server/VM as follows
This is a manual step. \
Remove the last line as shown below for the dtpuser entry.

sudo vi /etc/sudoers  
dtpuser ALL=(ALL) NOPASSWD: ALL
hadoop ALL=(ALL) NOPASSWD: ALL

## DataTachyonPlatform - Security

To install Security for DTP-Services please go to [DTP-Security](/common/security/README.md)
