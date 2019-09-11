# DataTachyonPlatform
Data Tachyon Platform

The Data Tachyon Platform provides a number of scripts that allows you to install and uninstall its components on premise and in the cloud.

The scripts can be copied to the target server and run manually or automated by creating a Jenkins job

hadoop_hive_installation.sh
=============

Use this script to setup the hadoop name node. The script takes six parameters �
TARGET_IP_ADDRESS � the IP address of the target node
TARGET_HOSTNAME � the host name of the remote hive server


uninstall_hadoop_hive.sh
========================

Use this script to remove the hadoop name node. The script takes six parameters �
TARGET_IP_ADDRESS � the IP address of the target node

pre_installation.sh
==============

Use this script to perform the necessary pre_installation. The scripts takes one parameter �
Requires for creating relevant users, assigning them to group and applying
changes where necessary to the config.
