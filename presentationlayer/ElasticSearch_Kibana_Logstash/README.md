# DTP-Elasticsearch Kibana Logstash(ELK)

## DTP-Elasticsearch Kibana Logstash Installation

### Setup DTP ELK Server before running Jenkins Job

1. To setup the ELK Server Host go to [DTP-Server-Host-Setup](/common/Readme.md).

### Create a Jenkins Job for DTP ELK Installer

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Elk-Installer.
![Create-DTP-ELK-Installer Jenkins](/presentationlayer/ElasticSearch_Kibana_Logstash/images/dtp-elk-install1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.
![DiscardBuild-DTP-ELK-Installer Jenkins](/presentationlayer/ElasticSearch_Kibana_Logstash/images/dtp-elk-install2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-ELK-Installer Jenkins](/presentationlayer/ElasticSearch_Kibana_Logstash/images/dtp-elk-install3.png)

7. The following scripts is used to create the Jenkins job \
[install_elk.sh.sh](/presentationlayer/ElasticSearch_Kibana_Logstash/scripts/install_elk.sh )
Use this script to setup the ELK.\
The script takes the following parameters.\
TARGET_USERNAME the username to login to ELK Server.\
TARGET_IP_ADDRESS the IP address of the ELK Server.\
SOURCE_SOFTWARE_LOCATION the source location for the ELK Tool on Jenkins Server.\
TARGET_SOFTWARE_LOCATION the target location on the ELK Server.\
INSTALLATION_FILE_TO_RUN the installation file to run for installing ELK.\
[test_elk_status.sh](/presentationlayer/ElasticSearch_Kibana_Logstash/scripts/test_elk_status.sh)\
Use this script to Test the ELK.\
The script takes the following parameters.\
TARGET_USERNAME the username to login to ELK Server.\
TARGET_IP_ADDRESS the IP address of the ELK Server.\

8. Under Build Option, Click on Add build step add the following steps.\
   **Execute shell and add the following commands**\
   whoami && pwd && hostname \
   sudo chmod 775 -R /home/dtpuser/ELK \
   cd /home/dtpuser/ELK \
   echo "Installing ELK on Remote sever " \
   ls -latr && ./install_elk.sh \

   ![AddBuildSteps-DTP-ELK-Installer Jenkins](/presentationlayer/ElasticSearch_Kibana_Logstash/images/dtp-elk-install4.png)

9. Save the Job.

### After Running Jenkins Job

1. Remove exception from sudoers file for the users dtpuser by removing the last line shown below:\
    sudo vi /etc/sudoers  \
    dtpuser ALL=(ALL) NOPASSWD: ALL

## DTP-ELK-Uninstallation

### Create a Jenkins Job for DTP ELK Uninstaller

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-ELK-Uninstaller.
![Create-DTP-ELK-Uninstaller Jenkins](/presentationlayer/ElasticSearch_Kibana_Logstash/images/dtp-elk-uninstall1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.
![DiscardBuild-DTP-ELK-Uninstaller Jenkins](/presentationlayer/ElasticSearch_Kibana_Logstash/images/dtp-elk-uninstall2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-ELK-Uninstaller Jenkins](/presentationlayer/ElasticSearch_Kibana_Logstash/images/dtp-elk-uninstall3.png)

7. The following scripts is used to create the Jenkins job \
[uninstall_elk.sh](/presentationlayer/ElasticSearch_Kibana_Logstash/scripts/uninstall_elk.sh)
Use this script to uninstall the ELK.\
The script takes the following parameters.\
TARGET_USERNAME the username to login to ELK Server.\
TARGET_IP_ADDRESS the IP address of the ELK Server.\
TARGET_SOFTWARE_LOCATION the target location on the ELK Server.\
UN_INSTALLATION_FILE_TO_RUN the  file to run for uninstalling ELK.

8. Under Build Option, Click on Add build step add the following steps.\
   **Execute shell and add the following commands**\
    whoami && pwd && hostname \
    sudo chmod 775 -R /home/dtpuser/*.sh \
    cd /home/dtpuser/  \
    echo "UnInstalling ELK on Remote sever " \
    ls -latr && ./uninstall_elk.sh \

    echo "Removing Nifi Installation Script on Remote sever " \
    sudo rm -rf /home/dtpuser/uninstall_elk.sh \

   ![AddBuildSteps-DTP-ELK-Installer Jenkins](/presentationlayer/ElasticSearch_Kibana_Logstash/images/dtp-elk-uninstall4.png)

9. Save the Job.



