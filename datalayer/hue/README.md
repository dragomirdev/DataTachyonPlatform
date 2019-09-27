# DataTachyonPlatform - Hue

## DTP-Hue Installation

### Setup DTP Hue Service before running Jenkins Job

1. To setup the DTP Hue Server go to [DTP-Server-Setup](/common/Readme.md).


### Create a Jenkins Job for DTP Hue Installer

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Hue-Installer.

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option. \
![DiscardBuild-DTP-Hue-Installer Jenkins](/datalayer/hue/images/Hue_Jenkins_setup_1.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-Hue-Installer Jenkins](/datalayer/hue/images/Hue_Jenkins_setup_2.png)
![Parameterise-DTP-Hue-Installer Jenkins](/datalayer/hue/images/Hue_Jenkins_setup_3.png)

7. The following scripts is used to create the Jenkins job to setup the Hue. \
[hadoop_hue_installation.sh](/datalayer/hue/scripts/hadoop_hue_installation.sh) \
The script the following parameters:\
HUE_VM_HOSTNAME � the hostname of the target node.\
HADOOP_NAMENODE_HOSTNAME � the host name of the remote Hadoop NameNode server. \
HIVE_NODE_HOSTNAME � the IP address of the target node.

8. Under Build Option, Click on Add build step add the following steps.\
   **Send Files or execute commands over SSH**\
   whoami && pwd && hostname \
   echo " ++++++++++++++++ Starting installation of Hue and its dependencies ++++++++++++++++ " \
   ls -latr \
   ./hadoop_hue_installation.sh "<HUE_VM_HOSTNAME>" "<HADOOP_NAMENODE_HOSTNAME>" "<HIVE_NODE_HOSTNAME>" \
   echo " ++++++++++++++++++++ Installation completed ++++++++++++++++++++++++ "

   ![AddBuildSteps-DTP-Hue-Installer Jenkins](/datalayer/hue/images/Hue_Jenkins_setup_4.png)

9. Save the Job.

10. Once the above Job ran successfully, Hue service should be up and running at,
HUE_VM_IP_ADDRESS:8000


### After Running Jenkins Job

1. Remove exception from sudoers file for the users dtpuser by removing the last line shown below:\
    sudo vi /etc/sudoers  \
    hadoop ALL=(ALL) NOPASSWD: ALL

## DTP-Hue-Uninstallation

### Create a Jenkins Job for DTP Hive Uninstaller

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Hue-Uninstaller.
![Create-DTP-Hue-Uninstaller Jenkins](/datalayer/hue/images/Hue_Jenkins_Uninstall_1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-Hue-Uninstaller Jenkins](/datalayer/hue/images/Hue_Jenkins_Uninstall_2.png)

7. The following script is used to create the Jenkins job \
[uninstall_hadoop_hue.sh](/datalayer/hue/scripts/uninstall_hadoop_hue.sh)
The script takes  parameters \
HUE_IP_ADDRESS:          the IP address of the target node.

8. Under Build Option, Click on Add build step add the following steps.\
   **Send Files or execute commands over SSH**\
   echo "*** Running uninstall script ***" \
   chmod 775 uninstall_hadoop_and hue.sh \
   ./uninstall_hadoop_hue.sh \
   echo "*** Removing uninstall script ***" \
   rm uninstall_hadoop_hue.sh

   ![AddBuildSteps-DTP-Hue-Uninstaller Jenkins](/datalayer/hue/images/Hue_Jenkins_Uninstall_2.png)

9. Save the Job.
