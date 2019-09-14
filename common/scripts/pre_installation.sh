
## Generate ssh keys
ssh-keygen -t rsa
<no password>

## add the public keys to the authorized keys
cat .ssh/id_rsa.pub >> .ssh/authorized_keys
sudo chmod -R 700 .ssh
sudo chmod -R 640 .ssh/authorized_keys

## adding the localhost keys to the known_hosts
ssh localhost

## Copying the public keys of the remote host/VM to the local .ssh/authorized_keys file.
## ssh-copy-id bothways i.e. from Jenkins to target VM and also from target VM to Jenkins
ssh-copy-id <USER>@<HOST_NAME>

# FOR ALL HOSTS/VMS IN THE DTP
# Create dtpuser user
sudo groupadd hadoop
sudo adduser --ingroup hadoop dtpuser
#### password: <PASSWORD>
#### set default values
sudo usermod -aG sudo dtpuser

# FOR HADOOP AND SPARK HOSTS/VMS ONLY IN THE DTP 
# Create hadoop user
sudo groupadd hadoop
sudo adduser --ingroup hadoop hadoop
#### password: <PASSWORD>
#### set default values
sudo usermod -aG sudo hadoop

# FOR SPARK HOSTS/VMS ONLY IN THE DTP 
# Create spark user
sudo groupadd hadoop
sudo adduser --ingroup hadoop spark
#### password: <PASSWORD>
#### set default values
sudo usermod -aG sudo spark
