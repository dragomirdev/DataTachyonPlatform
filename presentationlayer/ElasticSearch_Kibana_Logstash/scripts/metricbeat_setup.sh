#!/bin/bash

# curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.2.0-linux-x86_64.tar.gz

#################################################### METRICBEAT #################################################################

cd /opt/elk/
echo "Extracting MetricBeat...."
tar -xzf metricbeat-7.2.0-linux-x86_64.tar.gz
sudo mv metricbeat-7.2.0-linux-x86_64/ metricbeat

sudo chmod -R 775 /opt/elk/
sudo chown -R dtpuser:dtpuser /opt/elk/

ls -latr
$METRIC_BEAT_HOME=/opt/elk/metricbeat/

cd $METRIC_BEAT_HOME"/"

#Make sure the Elasticsearch and Kibana are setup and are currently running

ip_address=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
curl -X GET http://${ip_address}:9200

################ Manual Step to configure metribeat.yml #################################
#Make sure the IP Configuration for Kibana and elasticsearch are correctly configured
# along with the user authentication details as follows:
#============================== Kibana =====================================

# Starting with Beats version 6.0.0, the dashboards are loaded via the Kibana API.
# This requires a Kibana endpoint configuration.
setup.kibana:

  # Kibana Host
  # Scheme and port can be left out and will be set to the default (http and 5601)
  # In case you specify and additional path, the scheme is required: http://localhost:5601/path
  # IPv6 addresses should always be defined as: https://[2001:db8::1]:5601
  host: "10.0.4.5:5601"

  # Kibana Space ID
  # ID of the Kibana Space into which the dashboards should be loaded. By default,
  # the Default Space will be used.
  #space.id:

#-------------------------- Elasticsearch output ------------------------------
output.elasticsearch:
  # Array of hosts to connect to.
  hosts: ["10.0.4.5:9200"]

  # Optional protocol and basic auth credentials.
  #protocol: "https"
  username: "elastic"
  password: "JPSpace2019$"

#----------------------------- Logstash output --------------------------------
#output.logstash:
  # The Logstash hosts
  hosts: ["10.0.4.5:5044"]

################ End of Manual Step #################################

chmod go-w /opt/elk/metricbeat/metricbeat.yml
/opt/elk/metricbeat/metricbeat modules enable system
/opt/elk/metricbeat/metricbeat setup -e
chmod go-w /opt/elk/metricbeat/modules.d/system.yml
/opt/elk/metricbeat/metricbeat -e &
