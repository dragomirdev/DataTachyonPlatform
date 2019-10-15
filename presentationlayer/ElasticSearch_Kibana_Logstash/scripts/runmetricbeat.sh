#!/bin/bash

cd /opt/elk/metricbeat/

chmod go-w /opt/elk/metricbeat/metricbeat.yml
chmod go-w /opt/elk/metricbeat/modules.d/system.yml
/opt/elk/metricbeat/metricbeat -e &
