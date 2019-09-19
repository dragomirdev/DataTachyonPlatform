# DTP-Liferay

## DTP-Liferay Installation

### Setup DTP Liferay before running Jenkins Job

1. To setup the DTP Liferay  Host go to [DTP-Server-Setup](/common/Readme.md).

### Create a Jenkins Job for DTP Liferay Installer

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Liferay-Installer.
![Create-DTP-Liferay-Installer Jenkins](/presentationlayer/Liferay/images/dtp-liferay-install1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.
![DiscardBuild-DTP-Liferay-Installer Jenkins](/presentationlayer/Liferay/images/dtp-liferay-install2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-Liferay-Installer Jenkins](/presentationlayer/Liferay/images/dtp-liferay-install3.png)

7. The following scripts is used to create the Jenkins job \
[install_liferay.sh.sh](/presentationlayer/Liferay/scripts/install_liferay.sh )
Use this script to setup the Liferay.\
The script takes the following parameters.\
TARGET_USERNAME the username to login to Liferay Server.\
TARGET_IP_ADDRESS the IP address of the Liferay Server.\
SOURCE_SOFTWARE_LOCATION the source location for the Liferay Tool on Jenkins Server.\
TARGET_SOFTWARE_LOCATION the target location on the Liferay Server.\
INSTALLATION_FILE_TO_RUN the installation file to run for installing Liferay.\


8. Under Build Option, Click on Add build step add the following steps.\
   **Execute shell and add the following commands**\
   whoami && pwd && hostname \
   sudo chmod 775 -R /home/dtpuser/Liferay \
   cd /home/dtpuser/Liferay \
   echo "Installing Liferay on Remote sever " \
   ls -latr && ./install_liferay.sh \

   ![AddBuildSteps-DTP-Liferay-Installer Jenkins](/presentationlayer/Liferay/images/dtp-liferay-install4.png)

9. Save the Job.

### DTP Liferay Portal:

The Liferay once Started would be running on the following Link.

[DTP-Liferay-Portal](http://localhost:8080/web/datatachyonplatform)

The Following DTP Liferay Loging Page is shown.

![DTP-Liferay-Portal-Login](/presentationlayer/Liferay/images/dtp-liferay-portal1.png)

After Successful login using the Credentials provided to you,\
the DTP Liferay Welcome page is shown with tabs pointing to the DTP Software Tools.

![DTP-Liferay-Portal-Welcome](/presentationlayer/Liferay/images/dtp-liferay-portal2.png)

### After Running Jenkins Job

1. Remove exception from sudoers file for the users dtpuser by removing the last line shown below:\
    sudo vi /etc/sudoers  \
    dtpuser ALL=(ALL) NOPASSWD: ALL

## DTP-Liferay-Uninstallation

### Create a Jenkins Job for DTP Liferay Uninstaller

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Liferay-Uninstaller.
![Create-DTP-Liferay-Uninstaller Jenkins](/presentationlayer/Liferay/images/dtp-liferay-uninstall1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.
![DiscardBuild-DTP-Liferay-Uninstaller Jenkins](/presentationlayer/Liferay/images/dtp-liferay-uninstall2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-Liferay-Uninstaller Jenkins](/presentationlayer/Liferay/images/dtp-liferay-uninstall3.png)

7. The following scripts is used to create the Jenkins job \
[uninstall_liferay.sh](/presentationlayer/Liferay/scripts/uninstall_liferay.sh)
Use this script to uninstall the Liferay.\
The script takes the following parameters.\
TARGET_USERNAME the username to login to Liferay Server.\
TARGET_IP_ADDRESS the IP address of the Liferay Server.\
TARGET_SOFTWARE_LOCATION the target location on the Liferay Server.\
UN_INSTALLATION_FILE_TO_RUN the  file to run for uninstalling Liferay.

8. Under Build Option, Click on Add build step add the following steps.\
   **Execute shell and add the following commands**\
    whoami && pwd && hostname \
    sudo chmod 775 -R /home/dtpuser/*.sh \
    cd /home/dtpuser/  \
    echo "UnInstalling Liferay on Remote sever " \
    ls -latr && ./uninstall_liferay.sh \

    echo "Removing Liferay Installation Script on Remote sever " \
    sudo rm -rf /home/dtpuser/uninstall_liferay.sh \

   ![AddBuildSteps-DTP-Liferay-Installer Jenkins](/presentationlayer/Liferay/images/dtp-liferay-uninstall4.png)

9. Save the Job.

