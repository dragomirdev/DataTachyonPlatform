#!/bin/bash

sudo apt -y update && sudo apt -y upgrade
sudo apt -y install openjdk-8-jdk zip unzip net-tools curl
# Current default time zone:
sudo timedatectl set-timezone Europe/London


# FOR ALL HOSTS/VMS IN THE DTP
# Create dtpuser user
sudo groupadd hadoop
sudo adduser --ingroup hadoop dtpuser
#### password: <PASSWORD>
#### set default values
sudo usermod -aG sudo dtpuser

# FOR HADOOP AND SPARK HOSTS/VMS ONLY IN THE DTP 
# Create hadoop user
sudo groupadd hadoop
sudo adduser --ingroup hadoop hadoop
#### password: <PASSWORD>
#### set default values
sudo usermod -aG sudo hadoop



# FOR KAFKA HOSTS/VMS ONLY IN THE DTP
# Create kafka user
sudo useradd kafka -m
sudo passwd kafka
sudo adduser kafka sudo
sudo usermod -aG sudo kafka


## Login to each user on each server and generate the ssh keys
ssh-keygen -t rsa
<no password>
## adding the localhost keys to the known_hosts on each node
ssh localhost

## add the public keys to the authorized keys
cat .ssh/id_rsa.pub >> .ssh/authorized_keys
sudo chmod -R 700 .ssh
sudo chmod -R 640 .ssh/authorized_keys



## Copy the hosts names to the /etc/hosts
<JENKINS_IP_ADDRESS> JP-DTP-JENKINS-VM
<NIFI_IP_ADDRESS>  JP-DTP-NIFI-VM
<ELK_IP_ADDRESS>  JP-DTP-ELK-VM
<SPARK_MASTER_IP_ADDRESS>  JP-DTP-SPARK-VM
<SPARK_WORKER_IP_ADDRESS>  JP-DTP-SPARK-WORKER-VM
<HADOOP_NAMENODE_IP_ADDRESS>  JP-DTP-HADOOP-NM-VM
<HADOOP_DATANODE_IP_ADDRESS>  JP-DTP-HADOOP-DN1-VM


# enable PasswordAuthentication yes
sudo vim /etc/ssh/sshd_config
"PasswordAuthentication no" change to "PasswordAuthentication yes"
sudo service sshd reload

## Copying the public keys of the remote host/VM to the local .ssh/authorized_keys file.
## ssh-copy-id Bothways i.e. from JENKINS to TARGET HOSTS/VMS and also from TARGET VM to JENKINS HOSTS/VMS.
## This is also done for all the SPARK, HADOOP and all other Hosts/VMs for intercommunication.
ssh-copy-id <USER>@<HOST_NAME>



#Test SSH from each node to all other nodes.
ssh <USER>@<HOST_NAME>
# Eg:
# On Jenkins node run the following
ssh-copy-id hadoop@JP-DTP-HADOOP-NM-VM
ssh-copy-id hadoop@JP-DTP-HADOOP-SN-VM
ssh-copy-id hadoop@JP-DTP-HADOOP-DN1-VM
ssh-copy-id hadoop@JP-DTP-HADOOP-DN2-VM
ssh-copy-id hadoop@JP-DTP-SPARK-MASTER-VM
ssh-copy-id hadoop@JP-DTP-SPARK-WORKER-VM
ssh-copy-id hadoop@JP-DTP-NIFI-VM
ssh-copy-id hadoop@JP-DTP-ELK-VM

# On Each Node run the following
ssh-copy-id jenkins@JP-DTP-JENKINS-VM

# NOTE: Make sure for each Spark and Hadoop nodes we have the done the following checks
# ssh-copy-id hadoop@JP-DTP-HADOOP-<NODENAME>-VM
# ssh-copy-id hadoop@JP-DTP-SPARK-<NODENAME>-VM
# ssh localhost


# Add exception to sudoers file for the user dtpuser before DTP Installation on each Server/VM as follows:\
# Note: This is a manual step
sudo vi /etc/sudoers  
dtpuser ALL=(ALL) NOPASSWD: ALL
hadoop ALL=(ALL) NOPASSWD: ALL

# Note: Remove exception to sudoers file for the user dtpuser After the DTP Installation on the Server/VM as follows
# This is a manual step.
# Remove the last line as shown below for the dtpuser entry.
# sudo vi /etc/sudoers
# dtpuser ALL=(ALL) NOPASSWD: ALL hadoop ALL=(ALL) NOPASSWD: ALL

# Change PasswordAuthentication to no
sudo vim /etc/ssh/sshd_config
"PasswordAuthentication yes" change to "PasswordAuthentication no"
sudo service sshd reload

