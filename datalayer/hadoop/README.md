# DataTachyonPlatform
Data Tachyon Platform

The Data Tachyon Platform provides a number of scripts that allows you to install and uninstall its components on premise and in the cloud.

The scripts can be copied to the target server and run manually or automated by creating a Jenkins job

HADOOP_NN.sh
=============

Use this script to setup the hadoop name node. The script takes six parameters …
HADOOP_SNN_IP – the IP address of the secondary name node
HADOOP_SNN_NAME – the host name of the secondary name node
HADOOP_DN_ONE_IP – the IP address of the first data node
HADOOP_DN_ONE_NAME – the host name of the first data node
HADOOP_DN_TWO_IP – the IP address of the second data node
HADOOP_DN_TWO_NAME – the host name of the second data node

UNINSTALL_HADOOP_NN.sh
========================

Use this script to remove the hadoop name node. The script takes six parameters …
HADOOP_SNN_IP – the IP address of the secondary name node
HADOOP_SNN_NAME – the host name of the secondary name node
HADOOP_DN_ONE_IP – the IP address of the first data node
HADOOP_DN_ONE_NAME – the host name of the first data node
HADOOP_DN_TWO_IP – the IP address of the second data node
HADOOP_DN_TWO_NAME – the host name of the second data node

HADOOP_SNN.sh
==============

Use this script to setup the secondary name node. The scripts takes two parameters …
HADOOP_NN_IP – the IP address of the name name node
HADOOP_NN_NAME – the host name of the name name node

UNINSTALL_HADOOP_SNN.sh
=========================

Use this script to remove the hadoop secondary name node. The scripts takes two parameters …
HADOOP_NN_IP – the IP address of the name name node
HADOOP_NN_NAME – the host name of the name name node

HADOOP_DN.sh
=============

Use this script to setup a data node (i.e. data node one and two). The scripts takes two parameters …
HADOOP_NN_IP – the IP address of the name name node
HADOOP_NN_NAME – the host name of the name name node

UNINSTALL_HADOOP_DN.sh
========================

Use this script to remove a data node (i.e. data node one and two). The scripts takes two parameters …
HADOOP_NN_IP – the IP address of the name name node
HADOOP_NN_NAME – the host name of the name name node
=======



