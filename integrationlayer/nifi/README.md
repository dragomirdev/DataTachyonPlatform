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

[nifi_uninstaller.sh.sh] (/integrationlayer/nifi/scripts/nifi_uninstaller.sh.sh)
Use this script to uninstall the Nifi.\
The script takes the following parameters.\
TARGET_IP_ADDRESS the IP address of the Nifi Server.\
TARGET_SOFTWARE_LOCATION the target location on the Nifi Server.\
INSTALLATION_FILE_TO_RUN the installation file to run for installing Nifi.
