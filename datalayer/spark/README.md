# DataTachyonPlatform
Data Tachyon Platform

The Data Tachyon Platform provides a number of scripts that allows you to install and uninstall its components on premise and in the cloud.

The scripts can be copied to the target server and run manually or automated by creating a Jenkins job

[SPARK_MASTER.sh](https://github.com/dragomirdev/DataTachyonPlatform/blob/master/datalayer/spark/SPARK_MASTER.sh)
================

Use this script to setup the spark master.\
The scripts takes two parameters.\
SPARK_WORKER_IP - the IP address of the spark worker node.\
SPARK_WORKER_NAME - the host name of the spark worker node.

[UNINSTALL_SPARK_MASTER.sh](https://github.com/dragomirdev/DataTachyonPlatform/blob/master/datalayer/spark/UNINSTALL_SPARK_MASTER.sh)
==========================

Use this script to remove the spark master.\
The scripts takes two parameters.\
SPARK_WORKER_IP - the IP address of the spark worker node.\
SPARK_WORKER_NAME - the host name of the spark worker node.

[SPARK_WORKER.sh](https://github.com/dragomirdev/DataTachyonPlatform/blob/master/datalayer/spark/SPARK_WORKER.sh)
================

Use this script to setup a spark worker node.\
This script takes no parameters.

[UNINSTALL_SPARK_WORKER.sh](https://github.com/dragomirdev/DataTachyonPlatform/blob/master/datalayer/spark/UNINSTALL_SPARK_WORKER.sh)
===========================

Use this script to remove a spark worker node.\
This script takes no parameters.
