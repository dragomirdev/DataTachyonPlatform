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
Do ssh-copy-id:
ssh-copy-id <USER>@<HOST_NAME>
