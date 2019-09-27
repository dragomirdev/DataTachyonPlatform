#!/bin/bash

set -euxo pipefail

HUE_IP=$1
HADOOP_NN_IP=$2
HIVE_NODE_IP=$3

cd

echo "Hue installation is started"

# Install dependecies
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install openjdk-8-jdk
sudo apt-get -y install mysql-server
sudo apt-get update
sudo apt-get install -y git
sudo apt-get install -y ant
sudo apt-get install -y gcc g++
sudo apt-get install -y libffi-dev
sudo apt-get install -y libkrb5-dev libmysqlclient-dev
sudo apt-get install -y libssl-dev libsasl2-dev libsasl2-modules-gssapi-mit
sudo apt-get install -y libsqlite3-dev
sudo apt-get install -y libtidy-dev libxml2-dev libxslt-dev
sudo apt-get install -y make
sudo apt-get install -y maven
sudo apt-get install -y libldap2-dev
sudo apt-get install -y python-dev python-simplejson python-setuptools
sudo apt-get install -y libgmp3-dev
sudo apt-get install -y curl
sudo apt-get install -y daemon
sudo apt-get install -y python-eventlet python-daemon python-apt

curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
sudo apt-get install -y nodejs


sudo usermod -aG sudo hadoop

# Run commands as hadoop user and don't expand variables
sudo -i -u hadoop bash << 'EOF'

sudo mkdir /var/run/mysqld
sudo chmod 777 -R /var/run/mysqld

#Start the database server
sudo service mysql start

#Configure MySQL
sudo sh -c 'echo "
[mysqld]

bind-address=0.0.0.0
default-storage-engine=innodb
sql_mode=STRICT_ALL_TABLES
" >> /etc/mysql/my.cnf'


#sudo /etc/init.d/mysql stop
#sudo mysqld_safe --skip-grant-tables &
#mysql -uroot
rootpasswd=root
#sudo mysql -u root -p ${rootpasswd} -e 'use mysql; update user set authentication_string=PASSWORD("root") where User="root";'
#sudo mysql -u root -p ${rootpasswd} -e 'update user set plugin="mysql_native_password" where User="root";'
#sudo mysql -u root -p ${rootpasswd} -e 'use mysql; update user set authentication_string=PASSWORD("root") where User="root";'
#sudo mysql -u root -p ${rootpasswd} -e "flush privileges;"
#sudo /etc/init.d/mysql start

#Create a database for Hue (we call it "hue" but any name works) with UTF8 collation and grant user privileges:
sudo mysql -uroot -p${rootpasswd} -e "CREATE DATABASE hue default character set utf8 default collate utf8_general_ci;"
sudo mysql -uroot -p${rootpasswd} -e "grant all on hue.* to 'hadoop'@'%' identified by 'hadoop';"
sudo mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"


# Update bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" >> ~/.bashrc
echo "export HIVE_HOME=/opt/hive" >> ~/.bashrc
echo "export HADOOP_HOME=/opt/hadoop" >> ~/.bashrc
echo "export PYSPARK_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo "export PYSPARK_DRIVER_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo 'export PATH=$JAVA_HOME/bin:$HIVE_HOME/bin:$HADOOP_HOME/sbin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Install hue

cd /opt/
sudo mv /home/hadoop/hue-master.zip /opt/
sudo unzip hue-master.zip 
sudo mkdir /opt/hue
sudo cp -r hue-master/* /opt/hue/
sudo chown hadoop:hadoop -R /opt/hue
sudo chmod -R 775 /opt/hue
cd /opt/hue
make apps
rm -rf /opt/hue/desktop/conf.dist
cd /opt/hue/desktop/conf
mv pseudo-distributed.ini hue.ini
rm pseudo-distributed.ini.tmpl
sudo mv /home/hadoop/hue.ini /opt/hue/desktop/conf/
sudo chown hadoop:hadoop -R /opt/hue/desktop/conf/hue.ini
sudo chmod -R 775 /opt/hue/desktop/conf/hue.ini


cd /opt/
#sudo mv /home/hadoop/hue.zip /opt/
#sudo unzip hue.zip
#sudo chown -R hadoop:hadoop hue
#sudo chmod -R 775 hue

sudo mv /home/hadoop/hadoop_client.zip /opt/
sudo unzip hadoop_client.zip 
sudo mv /opt/opt/hadoop /opt/
sudo chown -R hadoop:hadoop hadoop
sudo chmod -R 775 hadoop

sudo mv /home/hadoop/hive_client.zip /opt/
sudo unzip hive_client.zip 
sudo mv /opt/opt/hive /opt/
sudo chown -R hadoop:hadoop hive
sudo chmod -R 775 hive

sudo rm -rf /opt/opt
sudo rm -rf /opt/hue-master/
sudo rm hue-master.zip hadoop_client.zip hive_client.zip

EOF

# Update the hue.ini file
sudo -i -u hadoop bash << EOF

source /home/hadoop/.bashrc
hdfs dfs -mkdir -p /tmp
hdfs dfs -chown hadoop:hadoop /tmp
hdfs dfs -chmod -R 777 /tmp

echo "as hadoop user"
echo $HUE_IP
echo $HADOOP_NN_IP
echo $HIVE_NODE_IP

# huehostip
# hadoopnamenodeip
# hiveserver2ip
cd /opt/hue/desktop/conf/
sed -i -e "s/huehostip/$HUE_IP/g" hue.ini
sed -i -e "s/hadoopnamenodeip/$HADOOP_NN_IP/g" hue.ini
sed -i -e "s/hiveserver2ip/$HIVE_NODE_IP/g" hue.ini
cd

/opt/hue/build/env/bin/hue dumpdata > /tmp/hue_db_dump.json
/opt/hue/build/env/bin/hue syncdb --noinput
/opt/hue/build/env/bin/hue migrate
#/opt/hue/build/env/bin/hue loaddata /tmp/hue_db_dump.json
/opt/hue/build/env/bin/hue dbshell
#/opt/hue/build/env/bin/hue runcpserver &

EOF

# setup Auto start Hue
sudo -i -u hadoop bash << EOF

sudo mv /home/hadoop/hue.service /etc/systemd/system/
sudo chmod 755 /etc/systemd/system/hue.service
sudo systemctl daemon-reload
sudo systemctl start hue
sudo systemctl enable hue

EOF

echo "Hue installation is finished"

