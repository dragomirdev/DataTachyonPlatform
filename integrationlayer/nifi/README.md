# DTP-Nifi Installation/Uninstallation

## DTP-Nifi-Installation

### Before Running Jenkins Job

[PreInstallation-DTP-Nifi-Installer Jenkins](/common/scripts/pre_installation.sh)
(1) Create the users dtpuser on the Nifi host/VM
(2) Add exception to sudoers file for the users dtpuser as follows:\
        sudo vi /etc/sudoers  \
        dtpuser ALL=(ALL) NOPASSWD: ALL
(3) Copy the public key of jenkins user on jenkins VM to dtpuser on Nifi VM.

### Create a Jenkins Job for DTP Nifi Installer

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Nifi-Installer.
![Create-DTP-Nifi-Installer Jenkins](/integrationlayer/nifi/images/dtp-nifi-installer1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.
![DiscardBuild-DTP-Nifi-Installer Jenkins](/integrationlayer/nifi/images/dtp-nifi-installer2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-Nifi-Installer Jenkins](/integrationlayer/nifi/images/dtp-nifi-installer3.png)

7. The following scripts is used to create the Jenkins job \
[nifi_remote_installation.sh](/integrationlayer/nifi/scripts/nifi_remote_installation.sh)
Use this script to setup the Nifi.\
The script takes the following parameters.\
TARGET_USERNAME: the username to login to Nifi Server.\
TARGET_IP_ADDRESS: the IP address of the Nifi Server.\
SOURCE_SOFTWARE_LOCATION: the source location for the Nifi Tool on Jenkins Server.\
TARGET_SOFTWARE_LOCATION: the target location on the Nifi Server.\
INSTALLATION_FILE_TO_RUN: the installation file to run for installing Nifi.

8. Under Build Option, Click on Add build step add the following steps.\
   **Execute shell and add the following commands**\
   whoami && hostname && pwd 

   echo "Installing Nifi on Remote sever "
   ls -latr && ./nifi_remote_installation.sh \
   echo "Removing Nifi Installation Script on Remote sever " \
   sudo rm -rf /home/dtpuser/nifi_remote_installation.sh

   ![AddBuildSteps-DTP-Nifi-Installer Jenkins](/integrationlayer/nifi/images/dtp-nifi-installer4.png)

9. Save the Job.

## DTP-Nifi-DataFlow Template

1. Once the Nifi is Up and running on say http://localhost:9090,
Open the browser and using the link to view the Weg GUI.

2. Upload the DTP Nifi Template using the template file:\
[DTP-Nifi-DataFlow-Template](/integrationlayer/nifi/template/Master_NiFi_Template_Data_to_HDFS.xml)
as shown:

![DTP-Nifi-DataFlow-Diagram](/integrationlayer/nifi/images/dtp_nifi_upload_template.png)

3. Once the Template is upload, the dataflow is as follows:

![DTP-Nifi-DataFlow-Diagram](/integrationlayer/nifi/images/dtp_nifi_dataflow.png)

### After Running Jenkins Job

(1) Remove exception from sudoers file for the users dtpuser by removing the last line shown below:\
    sudo vi /etc/sudoers  \
    dtpuser ALL=(ALL) NOPASSWD: ALL

## DTP-Nifi-Uninstallation

### Create a Jenkins Job for DTP Nifi Uninstaller

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Nifi-Uninstaller.
![Create-DTP-Nifi-Uninstaller Jenkins](/integrationlayer/nifi/images/dtp-nifi-uninstaller1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.
![DiscardBuild-DTP-Nifi-Uninstaller Jenkins](/integrationlayer/nifi/images/dtp-nifi-uninstaller2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-Nifi-Uninstaller Jenkins](/integrationlayer/nifi/images/dtp-nifi-uninstaller3.png)

7. The following scripts is used to create the Jenkins job \
[nifi_uninstaller.sh](/integrationlayer/nifi/scripts/nifi_uninstaller.sh)
Use this script to uninstall the Nifi.\
The script takes the following parameters.\
TARGET_USERNAME: the username to login to Nifi Server.\
TARGET_IP_ADDRESS: the IP address of the Nifi Server.\
TARGET_SOFTWARE_LOCATION: the target location on the Nifi Server.\
UN_INSTALLATION_FILE_TO_RUN: the file to run for uninstalling Nifi.

8. Under Build Option, Click on Add build step add the following steps.\
   **Execute shell and add the following commands**\
   whoami && pwd && hostname \
   sudo chmod -R 775 nifi_uninstaller.sh \
   echo "UnInstalling Nifi on Remote sever " \
   ls -latr && ./nifi_uninstaller.sh \

   echo "Removing Nifi Installation Script on Remote sever " \
   sudo rm -rf /home/dtpuser/nifi_uninstaller.sh \

   ![AddBuildSteps-DTP-Nifi-Installer Jenkins](/integrationlayer/nifi/images/dtp-nifi-uninstaller4.png)

9. Save the Job.
