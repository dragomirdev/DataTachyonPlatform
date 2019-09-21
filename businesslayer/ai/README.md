# DTP-AI-Packages

## DTP Businesss AI Package Installation

### Setup DTP Businesss AI Package before running Jenkins Job

1. To setup the DTP AI Packages  Host go to [DTP-Server-Setup](/common/Readme.md).

### Create a Jenkins Job for DTP AI Packages Installer

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Business-AI-Installer.
![Create-DTP-AI-Installer Jenkins](/businesslayer/ai/images/dtp-ai-install1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.
![DiscardBuild-DTP-AI-Installer Jenkins](/businesslayer/ai/images/dtp-ai-install2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-AI-Installer Jenkins](/businesslayer/ai/images/dtp-ai-install3.png)

7. The following scripts are used to create the Jenkins job to Install the AI Packages.

   ****DTP-AI-MachineLearning-Installer Job****\
   The following Script is used for installing Machine Learning Packages like Numpy, Scipy, Scikit-Learn, Pandas\
[Install Machine Learning Packages](/businesslayer/ai/machine-learning/scripts/install_ml_packages.sh)

   For Deep-Learning, we have the following Jenkins Job\
   **DTP-AI-DeepLearning-Installer Job** is made up of the following jobs

   **DTP-AI-Tensorflow-Installer**\
    The following Script are used for installing Deep Learning Packages\
    [Tensorflow Package Installation](/businesslayer/ai/deep-learning/tensorflow/scripts/install_tensorflow.sh)\
    [Tensorboard Package Installation](/businesslayer/ai/deep-learning/tensorboard/scripts/install_tensorboard.sh)

   **DTP-AI-Pytorch-Installer**
    The following Script are used for installing Deep Learning Packages\
    [Pytorch Package Installation](/businesslayer/ai/deep-learning/pytorch/scripts/install_pytorch.sh)

   The scripts takes the following parameters.\
   TARGET_USERNAME the username to login to AI Server.\
   TARGET_IP_ADDRESS the IP address of the AI Server.\
   SOURCE_SOFTWARE_LOCATION the source location for the AI Tools on Jenkins Server.\
   TARGET_SOFTWARE_LOCATION the target location on the AI Server.\
   INSTALLATION_FILE_TO_RUN the installation file to run for installing AI.

8. Under Build Option, Click on Add build step add the following steps.\
   **Execute shell and add the following commands**\
   whoami && pwd && hostname \
   sudo chmod 775 -R /home/dtpuser/ai \
   cd /home/dtpuser/ai \
   echo "Installing ai on Remote sever " \
   ls -latr && ./install_ai_packages.sh

   ![AddBuildSteps-DTP-ai-Installer Jenkins](/businesslayer/ai/images/dtp-ai-install4.png)

9. Save the Job.

### After Running Jenkins Job

1. Remove exception from sudoers file for the users hadoop by removing the last line shown below:\
    sudo vi /etc/sudoers  \
    hadoop ALL=(ALL) NOPASSWD: ALL

## DTP-Businesss-AI-Uninstallation

### Create a Jenkins Job for DTP Businesss AI Uninstaller

1. On Jenkins Home page, click on the New Item.

2. Enter the Item name say DTP-Business-AI-Uninstaller.
![Create-DTP-AI-Uninstaller Jenkins](/businesslayer/ai/images/dtp-ai-uninstall1.png)

3. Select FreeStyle Project and Ok.

4. Tick the Discard Builds checkbox and enter 2 for Max # of builds to keep option.
![DiscardBuild-DTP-AI-Uninstaller Jenkins](/businesslayer/ai/images/dtp-ai-uninstall2.png)

5. Tick the option, the  project  is parameterized.

6. Add the String parameters and configure for the following key value parameters. \
![Parameterise-DTP-AI-Uninstaller Jenkins](/businesslayer/ai/images/dtp-ai-uninstall3.png)

7. The following scripts iare used to create the Jenkins job to Uninstall the AI Packages.

   **Machine Learning Package Uninstallation**\
   The following Script is used for uninstalling Machine Learning Packages like Numpy, Scipy, Scikit-Learn, Pandas\
[Uninstall Machine Learning Packages](/businesslayer/ai/machine-learning/scripts/uninstall_ml_packages.sh)

   On similar lines, we have Jenkins Job for the following:
   **Deep Learning Package Uninstallation**\
   The following Script are used for installing Deep Learning Packages\
   [Tensorflow Package Uninstallation](/businesslayer/ai/deep-learning/tensorflow/scripts/uninstall_tensorflow.sh)\
   [Tensorboard Package Uninstallation](/businesslayer/ai/deep-learning/tensorboard/scripts/uninstall_tensorboard.sh)\
   [Pytorch Package Uninstallation](/businesslayer/ai/deep-learning/pytorch/scripts/uninstall_pytorch.sh)

   Use this script to uninstall the ai.\
   The script takes the following parameters.\
   TARGET_USERNAME the username to login to AI Server.\
   TARGET_IP_ADDRESS the IP address of the AI Server.\
   TARGET_SOFTWARE_LOCATION the target location on the AI Server.\
   UN_INSTALLATION_FILE_TO_RUN the  file to run for uninstalling AI.

8. Under Build Option, Click on Add build step add the following steps.\
   **Execute shell and add the following commands**\
    whoami && pwd && hostname \
    sudo chmod 775 -R /home/dtpuser/*.sh \
    cd /home/dtpuser/  \
    echo "UnInstalling ai on Remote sever " \
    ls -latr && ./uninstall_ai_packages.sh

    echo "Removing ai Installation Script on Remote sever " \
    sudo rm -rf /home/dtpuser/uninstall_ai_packages.sh

   ![AddBuildSteps-DTP-AI-Uninstaller Jenkins](/businesslayer/ai/images/dtp-ai-uninstall4.png)

9. Save the Job.

