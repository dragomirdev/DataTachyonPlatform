#!/bin/bash

# Prerequisite
sudo apt -y update && sudo apt -y upgrade
sudo apt -y install openjdk-8-jdk zip unzip net-tools curl
# Current default time zone:
sudo timedatectl set-timezone Europe/London
# Add Kafka User
sudo useradd kafka -m
sudo passwd kafka
sudo adduser kafka sudo
sudo usermod -aG sudo kafka

# Login as kafka User
sudo su - kafka

# Change PasswordAuthentication to no
sudo vim /etc/ssh/sshd_config
"PasswordAuthentication yes" change to "PasswordAuthentication no"
sudo service sshd reload


## Login to each user on each server and generate the ssh keys
ssh-keygen -t rsa
<no password>
## adding the localhost keys to the known_hosts on each node
ssh localhost

## add the public keys to the authorized keys
cat .ssh/id_rsa.pub >> .ssh/authorized_keys
sudo chmod -R 700 .ssh
sudo chmod -R 640 .ssh/authorized_keys


#Fixing zookeeper dns issue by modifying /etc/resolv.conf
cat /etc/resolv.conf | grep -v search | grep -v '#' > /tmp/resolv.conf
sudo chown root.root /tmp/resolv.conf
sudo chmod 664 /tmp/resolv.conf
sudo rm /etc/resolv.conf
sudo mv /tmp/resolv.conf /etc/resolv.conf

# Adding swap as vm has little ram
sudo swapon --show
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo bash -c 'echo "/swapfile swap swap defaults 0 0" >> /etc/fstab'
sudo swapon --show

# Deploying MicroK8s
sudo snap install microk8s --classic
sudo usermod -a -G microk8s $USER
sudo su - $USER 

echo "alias kubectl=microk8s.kubectl" >> ~/.bashrc 
echo "alias helm=microk8s.helm" >> ~/.bashrc 
source ~/.bashrc 
cat ~/.bashrc


# Enable microk8s dns storage helm
microk8s.status --wait-ready
microk8s.enable dns storage helm
microk8s.status --wait-ready
microk8s.kubectl get all --all-namespaces

# Configure your firewall to allow pod-to-pod and pod-to-internet communication
sudo ufw allow in on cni0 && sudo ufw allow out on cni0
sudo ufw default allow routed

########################################## ZOOKEEPER INSTALLATION
# Deploy zookeeper operator
cd $HOME
git clone https://github.com/pravega/zookeeper-operator.git
chmod -R 775 zookeeper-operator
cd zookeeper-operator/

# Create Namespace for zookeeper
kubectl create ns zookeeper
# Create zookeepercluster
kubectl -n zookeeper create -f deploy/crds/zookeeper_v1beta1_zookeepercluster_crd.yaml
# Create zookeeper-operator ServiceAccount, clusterrole.rbac.authorization, clusterrolebinding.rbac.authorization for k8s.io
kubectl -n zookeeper create -f deploy/all_ns/rbac.yaml
# Create the deployment.apps for zookeeper-operator
kubectl -n zookeeper create -f deploy/all_ns/operator.yaml


# Create namespace for cert-manager 
kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/v0.10.1/deploy/manifests/01-namespace.yaml
# Install cert-manager and CustomResourceDefinitions for namespace/serviceaccount/clusterrole/clusterrolebinding/rbac/deployments
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v0.10.1/cert-manager.yaml

# Deploy prometheus operator
kubectl apply -n default -f https://raw.githubusercontent.com/coreos/prometheus-operator/master/bundle.yaml

# List all pod with namespaces information
kubectl get pod --all-namespaces

########################################## KAFKA OPERATOR INSTALLATION
cd $HOME
git clone https://github.com/banzaicloud/kafka-operator.git
chmod -R 775 kafka-operator
cd kafka-operator
helm repo add banzaicloud-stable https://kubernetes-charts.banzaicloud.com/
# Install Tiller (the Helm server-side component)
helm init
# Deploy kafka operator
helm install --name=kafka-operator --namespace=kafka banzaicloud-stable/kafka-operator -f config/samples/example-prometheus-alerts.yaml
helm repo update





 