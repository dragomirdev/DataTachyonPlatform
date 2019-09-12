# DTP-Nifi Installation/Uninstallation

## DTP-Nifi-Installation

The scripts can be copied to the target server and run manually or automated by creating a Jenkins job

[nifi_remote_installation.sh] (/integrationlayer/nifi/scripts/nifi_remote_installation.sh)
Use this script to setup the Nifi.\
The script takes the following parameters.\
TARGET_IP_ADDRESS the IP address of the Nifi Server.\
SOURCE_SOFTWARE_LOCATION the source location for the Nifi Tool on Jenkins Server.\
TARGET_SOFTWARE_LOCATION the target location on the Nifi Server.\
INSTALLATION_FILE_TO_RUN the installation file to run for installing Nifi.

### Create a Jenkins Job for DTP Nifi Installer

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Nifi-Installer.
![Create-DTP-Nifi-Installer Jenkins](/integrationlayer/nifi/images/dtp-nifi-installer1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.
![DiscardBuild-DTP-Nifi-Installer Jenkins](/integrationlayer/nifi/images/dtp-nifi-installer2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
   TARGET_IP_ADDRESS: Hostname of the Target 
   SOURCE_SOFTWARE_LOCATION: Software location of the Nifi Tool
   TARGET_SOFTWARE_LOCATION: /home/dtpuser
   INSTALLATION_FILE_TO_RUN:/opt/DataTachyonPlatform/integrationlayer/nifi/scripts/nifi_remote_installation.sh
![Parameterise-DTP-Nifi-Installer Jenkins](/integrationlayer/nifi/images/dtp-nifi-installer3.png)

7. Under Build Option, Click on Add build step add the following steps
   **Execute shell and add the following commands**\
   whoami && hostname && pwd

   echo "Installing Nifi on Remote sever "
   ls -latr && ./nifi_remote_installation.sh
   echo "Removing Nifi Installation Script on Remote sever "
   sudo rm -rf /home/dtpuser/nifi_remote_installation.sh

   ![AddBuildSteps-DTP-Nifi-Installer Jenkins](/integrationlayer/nifi/images/dtp-nifi-installer4.png)

8. Save the Job.
