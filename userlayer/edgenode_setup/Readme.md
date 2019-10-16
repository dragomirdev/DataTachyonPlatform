# DataTachyonPlatform - Edgenode Setup

## DTP-Edgenode Installation

### Setup clients for DTP services on edgenode

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Edgenode-Installer.

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option. \
![DiscardBuild-DTP-Edgenode-Installer Jenkins](/userlayer/edgenode_setup/images/Edgenode_setup_1.png) 

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-Edgenode-Installer Jenkins](/userlayer/edgenode_setup/images/Edgenode_setup_2.png)

7. The following scripts is used to create the Jenkins job to setup the Edgenode. \
[hadoop_edgenode_installation.sh](/userlayer/edgenode_setup/scripts/hadoop_edgenode_installation.sh) \
The script the following parameters:\
EDGE_NODE_HOSTNAME � the hostname of the target node.\
SPARK_MASTER_HOSTNAME � the host name of the remote Spark Master server. 

8. Under Build Option, Click on Add build step add the following steps.\
   **Send Files or execute commands over SSH**\
   whoami && pwd && hostname \
   echo " ++++++++++++++++ Starting installation of Edgenode and its dependencies ++++++++++++++++ " \
   ls -latr \
   ./hadoop_edgenode_installation.sh "<EDGE_NODE_HOSTNAME>" "<SPARK_MASTER_HOSTNAME>" \
   echo " ++++++++++++++++++++ Installation completed ++++++++++++++++++++++++ "

   ![AddBuildSteps-DTP-Edgenode-Installer Jenkins](/userlayer/edgenode_setup/images/Edgenode_setup_3.png)
   

9. Save the Job.

10. Open the port 8888 on the VM.

11. Once the above Job ran successfully, Jupyter service should be up and running at,
EDGE_NODE_HOSTNAME:8888

