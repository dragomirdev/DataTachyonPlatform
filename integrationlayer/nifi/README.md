# DTP-Nifi Installation/Uninstallation

# DTP-Nifi-Installation

## Create a Jenkins Job for DTP Nifi Installer:

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Nifi-Installer.
![Create-DTP-Nifi-Installer Jenkins](/integrationlayer/nifi/images/dtp-nifi-installer1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.
![DiscardBuild-DTP-Nifi-Installer Jenkins](/integrationlayer/nifi/images/dtp-nifi-installer2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
   TARGET_IP_ADDRESS: JP-DTP-NIFI-VM
   SOURCE_SOFTWARE_LOCATION: /var/lib/jenkins/Tools/nifi-1.9.2-bin.zip
   TARGET_SOFTWARE_LOCATION: /home/dtpuser
   INSTALLATION_FILE_TO_RUN:nifi_remote_installation.sh
![Parameterise-DTP-Nifi-Installer Jenkins](/integrationlayer/nifi/images/dtp-nifi-installer3.png)

7. Under Build Option, Click on Add build step add the following steps
   **Execute shell and add the following commands**\
   whoami && hostname && pwd

   echo "Running SCP to transfer file to Remote Server:"$TARGET_USERNAME@$TARGET_IP_ADDRESS

   scp $SOURCE_SOFTWARE_LOCATION $TARGET_USERNAME@$TARGET_IP_ADDRESS:$TARGET_SOFTWARE_LOCATION

   scp $INSTALLATION_FILE_TO_RUN $TARGET_USERNAME@$TARGET_IP_ADDRESS:$TARGET_SOFTWARE_LOCATION

   **Execute shell script on remote host using ssh** \
   Select to run as a dtp user on the JP-DTP-NIFI-VM:

   echo "Installing Nifi on Remote sever "
   ls -latr && ./nifi_remote_installation.sh

   ![AddBuildSteps-DTP-Nifi-Installer Jenkins](/integrationlayer/nifi/images/dtp-nifi-installer4.png)

8. Save the Job.
