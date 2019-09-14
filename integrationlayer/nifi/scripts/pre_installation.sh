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
## ssh-copy-id bothways i.e. from Jenkins to Nifi and also from Nifi to Jenkins
ssh-copy-id <USER>@<HOST_NAME>


# Create dtpuser user
sudo groupadd hadoop
sudo adduser --ingroup hadoop dtpuser
#### password: hadoop
#### set default values
sudo usermod -aG sudo dtpuser

