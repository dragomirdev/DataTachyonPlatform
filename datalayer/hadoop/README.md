# DataTachyonPlatform - Hadoop Distributed File System (HDFS)

## DTP-HDFS Installation

This following HDFS setup consist of

* Single NameNode
* Single Secondary NameNode
* One or more DataNodes

### Setup DTP HDFS Server before running Jenkins Job

1. To setup the DTP HDFS Server (For NameNode, Secondary NameNode, DataNodes on each individual Server Nodes/VM) go to [DTP-Server-Setup](/common/Readme.md).

### Create a Jenkins Job for DTP HDFS Primary NameNode Installer

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Hadoop-Namenode-Installer.
![Create-DTP-ELK-Installer Jenkins](/datalayer/hadoop/images/dtp-hadoop-nn-installer1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.
![DiscardBuild-DTP-HDFS-NN-Installer Jenkins](/datalayer/hadoop/images/dtp-hadoop-nn-installer2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-HDFS-NN-Installer Jenkins](/datalayer/hadoop/images/dtp-hadoop-nn-installer3.png)

7. The following scripts is used to create the Jenkins job to setup the hadoop primary name node\
[HADOOP_NN.sh](/datalayer/hadoop/scripts/HADOOP_NN.sh) \
The script takes six parameters.\
HADOOP_SNN_IP – the IP address of the secondary name node.\
HADOOP_SNN_NAME – the host name of the secondary name node.\
HADOOP_DN_ONE_IP – the IP address of the first data node.\
HADOOP_DN_ONE_NAME – the host name of the first data node.\
HADOOP_DN_TWO_IP – the IP address of the second data node.\
HADOOP_DN_TWO_NAME – the host name of the second data node.

8. Under Build Option, Click on Add build step add the following steps.\
   **Send Files or execute commands over SSH**\
   echo "*** Finished copying installation files ***" \
   echo "*** Running installation script ***" \
   chmod 775 install_hadoop_namenode.sh \
   ./install_hadoop_namenode.sh $HADOOP_SNN_IP $HADOOP_SNN_NAME $HADOOP_DN1_IP $HADOOP_DN1_NAME $HADOOP_DN2_IP $HADOOP_DN2_NAME \
   echo "*** Removing installation files ***" \
   rm install_hadoop_namenode.sh \

   ![AddBuildSteps-DTP-HDFS-NN-Installer Jenkins](/datalayer/hadoop/images/dtp-hadoop-nn-installer4.png)

9. Save the Job.

On Similar lines create the following Jenkins Jobs.

### Create the Jenkins Job for DTP HDFS Secondary NameNode Installer

1. Use the following Script to setup the secondary name node: \
[HADOOP_SNN.sh](/datalayer/hadoop/HADOOP_SNN.sh) \
The scripts takes two parameters.\
HADOOP_NN_IP – the IP address of the name name node.\
HADOOP_NN_NAME – the host name of the name name node.

### Create the Jenkins Job for DTP HDFS DataNode(s) Installer

1. Use the following Script to setup the DataNode node (i.e. data node one and two): \
[HADOOP_DN.sh](/datalayer/hadoop/HADOOP_DN.sh) \
The scripts takes two parameters.\
HADOOP_NN_IP – the IP address of the name name node.
HADOOP_NN_NAME – the host name of the name name node.

2. Under Build Option, Click on Add build step add the following steps.\
   **Send Files or execute commands over SSH**\
   echo "*** Finished copying installation files ***" \
   echo "*** Running installation script ***" \
   chmod 775 install_hadoop_datanode.sh \
   ./install_hadoop_datanode.sh $HADOOP_NN_IP $HADOOP_NN_NAME \
   echo "*** Removing installation files ***" \
   rm install_hadoop_datanode.sh \

![AddBuildSteps-DTP-HDFS-DN-Installer Jenkins](/datalayer/hadoop/images/dtp-hadoop-dn-installer1.png)

### After Running Jenkins Job

1. Remove exception from sudoers file for the users dtpuser by removing the last line shown below:\
    sudo vi /etc/sudoers  \
    dtpuser ALL=(ALL) NOPASSWD: ALL

## DTP-HDFS-Uninstallation

### Create a Jenkins Job for DTP HDFS Primary NameNode Uninstaller

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Hadoop-Datanode-One-Uninstaller.
![Create-DTP-Hadoop-Datanode-One-Uninstaller Jenkins](/datalayer/hadoop/images/dtp-hadoop-nn-uninstaller1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.
![DiscardBuild-DTP-Hadoop-Datanode-One-Uninstaller Jenkins](/datalayer/hadoop/images/dtp-hadoop-nn-uninstaller2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-Hadoop-Datanode-One-Uninstaller Jenkins](/datalayer/hadoop/images/dtp-hadoop-nn-uninstaller3.png)

7. The following script is used to create the Jenkins job \
[UNINSTALL_HADOOP_NN.sh](/datalayer/hadoop/scripts/UNINSTALL_HADOOP_NN.sh) \
Use this script to remove the hadoop name node.\
The script takes six parameters.\
HADOOP_SNN_IP – the IP address of the secondary name node.\
HADOOP_SNN_NAME – the host name of the secondary name node.\
HADOOP_DN_ONE_IP – the IP address of the first data node.\
HADOOP_DN_ONE_NAME – the host name of the first data node.\
HADOOP_DN_TWO_IP – the IP address of the second data node.\
HADOOP_DN_TWO_NAME – the host name of the second data node.

8. Under Build Option, Click on Add build step add the following steps.\
   **Send Files or execute commands over SSH**\
    echo "*** Finished copying uninstall files ***"
    echo "*** Running uninstall script ***"
    chmod 775 uninstall_hadoop_datanode.sh
    ./uninstall_hadoop_datanode.sh $HADOOP_NN_IP $HADOOP_NN_NAME
    echo "*** Removing uninstall script ***"
    rm uninstall_hadoop_datanode.sh

   ![AddBuildSteps-DTP-Hadoop-Datanode-One-Installer Jenkins](/datalayer/hadoop/images/dtp-hadoop-nn-uninstaller4.png)

9. Save the Job.

On Similar lines create the following Jenkins Jobs.

### Create the Jenkins Job for DTP HDFS Secondary NameNode Uninstaller

1. Use the following Script to remove the secondary name node: \
[UNINSTALL_HADOOP_SNN.sh](/datalayer/hadoop/UNINSTALL_HADOOP_SNN.sh) \
The scripts takes two parameters.\
HADOOP_NN_IP – the IP address of the name name node.\
HADOOP_NN_NAME – the host name of the name name node..

### Create the Jenkins Job for DTP HDFS DataNode(s) Uninstaller

1. Use the following Script to remove the DataNode node (i.e. data node one and two): \
[UNINSTALL_HADOOP_DN.sh](/datalayer/hadoop/scripts/UNINSTALL_HADOOP_DN.sh) \
The scripts takes two parameters\
HADOOP_NN_IP – the IP address of the name name node.\
HADOOP_NN_NAME – the host name of the name name node.

2. Under Build Option, Click on Add build step add the following steps.\
   **Send Files or execute commands over SSH**\
   echo "*** Running uninstall script ***" \
   chmod 775 uninstall_hadoop_datanode.sh \
   ./uninstall_hadoop_datanode.sh $HADOOP_NN_IP $HADOOP_NN_NAME \
   echo "*** Removing uninstall script ***" \
   rm uninstall_hadoop_datanode.sh 

![AddBuildSteps-DTP-HDFS-DN-Uninstaller Jenkins](/datalayer/hadoop/images/dtp-hadoop-dn-uninstaller1.png)
