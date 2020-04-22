
#!/bin/bash
source ~/.bash_profile
echo "Stopping Hadoop"
cd /opt/hadoop
/opt/hadoop/sbin/stop-dfs.sh
/opt/hadoop/sbin/stop-yarn.sh


