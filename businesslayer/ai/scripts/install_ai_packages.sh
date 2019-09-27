#!/bin/bash

###Note##
#Before running job ...
#(1) Create the users hadoop on AI VM
#(2) Add exception to sudoers file for the users hadoop
#(3) Copy the public key of jenkins user on jenkins VM to hadoop on AI VM

#set -euxo pipefail

# Install dependecies
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install openjdk-8-jdk zip unzip net-tools ncdu inxi dstat iftop vnstat bmon nmap tcpdump nfs-common ack-grep zip unzip htop vim nano 
sudo apt -y install exfat-fuse exfat-utils unity-tweak-tool gimp conky curl
sudo apt -y autoremove

python3 -V

sudo apt -y install  python3-pip python3-dev
sudo wget https://bootstrap.pypa.io/get-pip.py
sudo python3.6 get-pip.py
sudo pip3 install -U setuptools pip

sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update && sudo apt upgrade -y
sudo apt-get update && sudo apt-get upgrade -y 
sudo apt -y install gnome-disk-utility cryptsetup
sudo apt-get -y install python-apt python3-apt python3.6-dev

sudo apt -y install libatlas-base-dev gfortran build-dep python3-lxml
sudo apt -y install libxml2-dev libxslt-dev libzmq3-dev libjpeg-dev
sudo apt-get -y install build-essential libssl-dev libffi-dev python3.6-dev python3-pip libsasl2-dev libldap2-dev
sudo apt-get -y install libopenblas-dev liblapack-dev libatlas-base-dev
sudo apt -y install python3-h5py
sudo pip3 install keras textblob nltk 
sudo pip3 install scikit-build --user
sudo pip3 install gensim
sudo apt -y install python3-numpy python3-matplotlib ipython python3-pandas python3-sympy python3-nose python3-seaborn python3-scipy
sudo pip3 install pyzmq jupyter http://h2o-release.s3.amazonaws.com/h2o/rel-wright/5/Python/h2o-3.20.0.5-py2.py3-none-any.whl h2o_pysparkling_2.2
sudo pip3 install keras textblob nltk tensorflow
sudo pip3  install numpy pyparsing==2.2.0
sudo pip3 install findspark  numexpr scikit-learn==0.19.2 hdfs pywebhdfs snakebite hdfs3 graphviz==0.8.4 xgboost
sudo pip3 install requests>=2.18.4 flask-wtf==0.14 sqlalchemy docutils lockfile libhdf5-serial-dev hdf5-tools bokeh seaborn
sudo pip3 install -U numpy scipy pandas nvidia-ml-py3 bottleneck
sudo pip3 install torch spacy==2.0.18 torchvision fastai

#sudo pip3 install --upgrade notebook
#sudo pip3 install ipython-sql cython rpy2
# Login as dtpuser Run the following commands manually.
#jupyter notebook --generate-config

# Manual one time step to store password
# jupyter notebook password

# Manual step Run Jupyter Notebook
# jupyter notebook --ip=0.0.0.0 --no-browser

sudo apt -y autoremove

pip3 list


