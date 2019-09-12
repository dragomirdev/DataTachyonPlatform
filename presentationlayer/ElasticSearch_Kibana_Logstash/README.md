# DTP-Elasticsearch Kibana Logstash(ELK) Installation/Uninstallation

## DTP-Elasticsearch Kibana Logstash Installation

The scripts can be copied to the target server and run manually or automated by creating a Jenkins job

[install_elk.sh.sh](/presentationlayer/ElasticSearch_Kibana_Logstash/scripts/install_elk.sh )

Use this script to setup the ELK.\
The script takes the following parameters.\
TARGET_USERNAME the username to login to ELK Server.\
TARGET_IP_ADDRESS the IP address of the ELK Server.\
SOURCE_SOFTWARE_LOCATION the source location for the ELK Tool on Jenkins Server.\
TARGET_SOFTWARE_LOCATION the target location on the ELK Server.\
INSTALLATION_FILE_TO_RUN the installation file to run for installing ELK.

[uninstall_elk.sh](/presentationlayer/ElasticSearch_Kibana_Logstash/scripts/uninstall_elk.sh)

Use this script to uninstall the Nifi.\
The script takes the following parameters.\
TARGET_USERNAME the username to login to Nifi Server.\
TARGET_IP_ADDRESS the IP address of the Nifi Server.\
TARGET_SOFTWARE_LOCATION the target location on the Nifi Server.\
UN_INSTALLATION_FILE_TO_RUN the  file to run for uninstalling Nifi.


