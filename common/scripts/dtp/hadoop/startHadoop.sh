
#!/bin/bash
source ~/.bash_profile
echo "Starting Hadoop"
cd /opt/hadoop

/opt/hadoop/sbin/start-dfs.sh
/opt/hadoop/sbin/start-yarn.sh

