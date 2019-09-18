# DataTachyonPlatform - Spark

## DTP-Spark Installation

### Setup DTP Spark Server before running Jenkins Job

1. To setup the DTP Spark Server go to [DTP-Server-Setup](/common/Readme.md).

### Create a Jenkins Job for DTP Spark Master Installer

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Spark-Installer.
![Create-DTP-Spark-Installer Jenkins](/datalayer/spark/images/dtp_spark_installer1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.
![DiscardBuild-DTP-Spark-Installer Jenkins](/datalayer/spark/images/dtp_spark_installer2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-Spark-Installer Jenkins](/datalayer/spark/images/dtp_spark_installer3.png)

7. The following scripts is used to create the Jenkins job to setup the Spark master. \
[SPARK_MASTER.sh](/datalayer/spark/scripts/SPARK_MASTER.sh) \
Use this script to setup the spark master.\
The scripts takes two parameters.\
SPARK_WORKER_IP - the IP address of the spark worker node.\
SPARK_WORKER_NAME - the host name of the spark worker node.

8. Under Build Option, Click on Add build step add the following steps.\
   **Send Files or execute commands over SSH**\
  echo "*** Finished copying installation files ***" \
  echo "*** Running installation script ***" \
  chmod 775 install_spark_master.sh \
  ./install_spark_master.sh $SPARK_WORKER_IP $SPARK_WORKER_NAME \
  echo "*** Removing installation files ***"
  rm install_spark_master.sh

![AddBuildSteps-DTP-Spark-Installer Jenkins](/datalayer/spark/images/dtp_spark_installer4.png)

9. Save the Job.

On Similar lines create the following Jenkins Jobs.

### Create the Jenkins Job for DTP Spark Worker Installer

1. Use the following Script to setup the Spark Worker node: \
[SPARK_WORKER.sh]/datalayer/spark/scripts/SPARK_WORKER.sh) \
This script takes no parameters.

2. Under Build Option, Click on Add build step add the following steps.\
   **Send Files or execute commands over SSH**\
   echo "*** Finished copying installation files ***" \
   echo "*** Running installation script ***" \
   chmod 775 install_spark_worker.sh \
   ./install_spark_worker.sh  \
   echo "*** Removing installation files ***" \
   rm install_spark_worker.sh

![AddBuildSteps-DTP-Spark-Worker-Installer Jenkins](/datalayer/spark/images/dtp_spark_worker_installer1.png)


### After Running Jenkins Job

1. Remove exception from sudoers file for the users dtpuser by removing the last line shown below:\
    sudo vi /etc/sudoers  \
    hadoop ALL=(ALL) NOPASSWD: ALL

## DTP-Spark-Uninstallation

### Create a Jenkins Job for DTP Spark Master Uninstaller

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Spark-Uninstaller.
![Create-DTP-Spark-Uninstaller Jenkins](/datalayer/spark/images/dtp_spark_uninstaller1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.
![DiscardBuild-DTP-Spark-Uninstaller Jenkins](/datalayer/spark/images/dtp_spark_uninstaller2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-Spark-Uninstaller Jenkins](/datalayer/spark/images/dtp_spark_uninstaller3.png)

7. The following script is used to create the Jenkins job \
Use this script to remove the spark master.\
[uninstall_spark_master.sh](/datalayer/spark/scripts/uninstall_spark_master.sh)
Use this script to remove the spark master.\
The scripts takes two parameters.\
SPARK_WORKER_IP - the IP address of the spark worker node.\
SPARK_WORKER_NAME - the host name of the spark worker node.

8. Under Build Option, Click on Add build step add the following steps.\
   **Send Files or execute commands over SSH**\
   echo "*** Finished copying uninstall files ***" \
   echo "*** Running unistall script ***" \
   chmod 775 uninstall_spark_master.sh \
   ./uninstall_spark_master.sh $SPARK_WORKER_IP $SPARK_WORKER_NAME \
   echo "*** Removing uninstall files ***" \
   rm uninstall_spark_master.sh

   ![AddBuildSteps-DTP-Spark-Uninstaller Jenkins](/datalayer/spark/images/dtp_spark_uninstaller4.png)

9. Save the Job.

On Similar lines create the following Jenkins Jobs.

### Create the Jenkins Job for DTP Spark Worker Uninstaller

1. Use the following Script to remove the Spark Worker node: \
[UNINSTALL_SPARK_WORKER.sh]/datalayer/spark/scripts/UNINSTALL_SPARK_WORKER.sh) \
This script takes no parameters.

2. Under Build Option, Click on Add build step add the following steps.\
   **Send Files or execute commands over SSH**\
   echo "*** Finished copying installation files ***" \
   echo "*** Running installation script ***" \
   chmod 775 uninstall_spark_worker.sh \
   ./uninstall_spark_worker.sh  \
   echo "*** Removing installation files ***" \
   rm uninstall_spark_worker.sh

![AddBuildSteps-DTP-Spark-Worker-Uninstaller Jenkins](/datalayer/spark/images/dtp_spark_worker_uninstaller1.png)
