# DataTachyonPlatform - Hive

## DTP-Hive Installation

### Setup DTP Hive Server before running Jenkins Job

1. To setup the DTP Hive Server go to [DTP-Server-Setup](/common/Readme.md).

### Create a Jenkins Job for DTP Hive Installer

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Hive-Installer.
![Create-DTP-Hive-Installer Jenkins](/datalayer/hive/images/dtp_hive_installer1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.
![DiscardBuild-DTP-Hive-Installer Jenkins](/datalayer/hive/images/dtp_hive_installer2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-Hive-Installer Jenkins](/datalayer/hive/images/dtp_hive_installer3.png)

7. The following scripts is used to create the Jenkins job to setup the Hive. \
[hadoop_hive_installation.sh](/datalayer/hive/scripts/hadoop_hive_installation.sh) \
The script the following parameters:\
TARGET_IP_ADDRESS � the IP address of the target node.\
TARGET_HOSTNAME � the host name of the remote hive server.

8. Under Build Option, Click on Add build step add the following steps.\
   **Send Files or execute commands over SSH**\
   whoami && pwd && hostname \
   echo " ++++++++++++++++ Starting installation of Hive and its dependencies ++++++++++++++++ " \
   ls -latr \
   ./hadoop_hive_installation.sh "<JP-DTP-HIVE-VM-IP-ADDRESS>" \
   echo " ++++++++++++++++++++ Installation completed ++++++++++++++++++++++++ "

   ![AddBuildSteps-DTP-Hive-Installer Jenkins](/datalayer/hive/images/dtp_hive_installer4.png)

9. Save the Job.

### After Running Jenkins Job

1. Remove exception from sudoers file for the users dtpuser by removing the last line shown below:\
    sudo vi /etc/sudoers  \
    hadoop ALL=(ALL) NOPASSWD: ALL

## DTP-Hive-Uninstallation

### Create a Jenkins Job for DTP Hive Uninstaller

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Hive-Uninstaller.
![Create-DTP-Hive-Uninstaller Jenkins](/datalayer/hive/images/dtp_hive_uninstaller1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.
![DiscardBuild-DTP-Hive-Uninstaller Jenkins](/datalayer/hive/images/dtp_hive_uninstaller2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-Hive-Uninstaller Jenkins](/datalayer/hive/images/dtp_hive_uninstaller3.png)

7. The following script is used to create the Jenkins job \
[uninstall_hadoop_hive.sh](/datalayer/hive/scripts/uninstall_hadoop_hive.sh)
The script takes  parameters \
HIVE_IP_ADDRESS:          the IP address of the target node.
HIVE_HOST_NAME:           the host name of the target node.\
SOFTWARE_SOURCE_LOCATION: the location of the script to be run on target node.

8. Under Build Option, Click on Add build step add the following steps.\
   **Send Files or execute commands over SSH**\
   echo "*** Running uninstall script ***" \
   chmod 775 uninstall_hadoop_and hive.sh \
   ./uninstall_hadoop_and hive.sh \
   echo "*** Removing uninstall script ***" \
   rm uninstall_hadoop_and hive.sh

   ![AddBuildSteps-DTP-Hive-Uninstaller Jenkins](/datalayer/hive/images/dtp_hive_uninstaller4.png)

9. Save the Job.