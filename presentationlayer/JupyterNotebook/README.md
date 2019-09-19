# DTP-Jupyter NoteBook

## DTP-Jupyter NoteBook Installation

### Setup DTP Jupyter NoteBook before running Jenkins Job

1. To setup the DTP Jupyter NoteBook  Host go to [DTP-Server-Setup](/common/Readme.md).

### Create a Jenkins Job for DTP Jupyter NoteBook Installer

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Jupyter NoteBook-Installer.

![Create-DTP-Jupyter NoteBook-Installer Jenkins](/presentationlayer/JupyterNotebook/images/dtp-jupyter-install1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.

![DiscardBuild-DTP-JupyterNoteBook-Installer Jenkins](/presentationlayer/JupyterNotebook/images/dtp-jupyter-install2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \

![Parameterise-DTP-JupyterNoteBook-Installer Jenkins](/presentationlayer/JupyterNotebook/images/dtp-jupyter-install3.png)

7. The following scripts is used to create the Jenkins job \
[install_jupyter.sh.sh](/presentationlayer/JupyterNoteBook/scripts/install_jupyter.sh )
Use this script to setup the JupyterNoteBook.\
The script takes the following parameters.\
TARGET_USERNAME the username to login to JupyterNoteBook Server.\
TARGET_IP_ADDRESS the IP address of the JupyterNoteBook Server.\
SOURCE_SOFTWARE_LOCATION the source location for the JupyterNoteBook Tool on Jenkins Server.\
TARGET_SOFTWARE_LOCATION the target location on the JupyterNoteBook Server.\
INSTALLATION_FILE_TO_RUN the installation file to run for installing JupyterNoteBook.\

8. Under Build Option, Click on Add build step add the following steps.\
   **Execute shell and add the following commands**\
   whoami && pwd && hostname \
   sudo chmod 775 -R /home/dtpuser/JupyterNoteBook \
   cd /home/dtpuser/JupyterNoteBook \
   echo "Installing JupyterNoteBook on Remote sever " \
   ls -latr && ./install_jupyter.sh

   ![AddBuildSteps-DTP-JupyterNoteBook-Installer Jenkins](/presentationlayer/JupyterNotebook/images/dtp-jupyter-install4.png)

9. Save the Job.

### DTP JupyterNoteBook Portal

The JupyterNoteBook once Started & configured with DTP would be running on the following Link.

[DTP-JupyterNoteBook-Portal](http://localhost:8888/)

The Following DTP JupyterNoteBook Loging Page is shown.

![DTP-JupyterNoteBook-Portal-Login](/presentationlayer/JupyterNoteBook/images/dtp-jupyter-portal1.png)

After Successful login using the Credentials provided to you,\
the DTP JupyterNoteBook Home page is shown with tabs pointing to the Home Folder.

![DTP-JupyterNoteBook-Portal-Welcome](/presentationlayer/JupyterNoteBook/images/dtp-jupyter-portal2.png)

### After Running Jenkins Job

1. Remove exception from sudoers file for the users dtpuser by removing the last line shown below:\
    sudo vi /etc/sudoers  \
    dtpuser ALL=(ALL) NOPASSWD: ALL

## DTP-JupyterNoteBook-Uninstallation

### Create a Jenkins Job for DTP JupyterNoteBook Uninstaller

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-JupyterNoteBook-Uninstaller.
![Create-DTP-JupyterNoteBook-Uninstaller Jenkins](/presentationlayer/JupyterNotebook/images/dtp-jupyter-uninstall1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.
![DiscardBuild-DTP-JupyterNoteBook-Uninstaller Jenkins](/presentationlayer/JupyterNotebook/images/dtp-jupyter-uninstall2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-JupyterNoteBook-Uninstaller Jenkins](/presentationlayer/JupyterNotebook/images/dtp-jupyter-uninstall3.png)

7. The following scripts is used to create the Jenkins job \
[uninstall_jupyter.sh](/presentationlayer/JupyterNoteBook/scripts/uninstall_jupyter.sh)
Use this script to uninstall the JupyterNoteBook.\
The script takes the following parameters.\
TARGET_USERNAME the username to login to JupyterNoteBook Server.\
TARGET_IP_ADDRESS the IP address of the JupyterNoteBook Server.\
TARGET_SOFTWARE_LOCATION the target location on the JupyterNoteBook Server.\
UN_INSTALLATION_FILE_TO_RUN the  file to run for uninstalling JupyterNoteBook.

8. Under Build Option, Click on Add build step add the following steps.\
   **Execute shell and add the following commands**\
    whoami && pwd && hostname \
    sudo chmod 775 -R /home/dtpuser/*.sh \
    cd /home/dtpuser/  \
    echo "UnInstalling JupyterNoteBook on Remote sever " \
    ls -latr && ./uninstall_jupyter.sh \

    echo "Removing JupyterNoteBook Installation Script on Remote sever " \
    sudo rm -rf /home/dtpuser/uninstall_jupyter.sh \

   ![AddBuildSteps-DTP-JupyterNoteBook-Installer Jenkins](/presentationlayer/JupyterNotebook/images/dtp-jupyter-uninstall4.png)

9. Save the Job.

