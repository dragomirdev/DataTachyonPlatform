#!/bin/bash

echo "************ Refreshing Hive Tables*********"
hive --service beeline << EOF
!connect jdbc:hive2://10.0.4.10:10000 hadoop hadoop
show databases;
USE DTPSTREAMINGDB;
show tables;
DESC SENSOR_INFO;
MSCK REPAIR TABLE SENSOR_INFO;
SELECT * FROM SENSOR_INFO;
desc ES_SENSOR_INFO;
INSERT OVERWRITE TABLE  ES_SENSOR_INFO   SELECT *  FROM SENSOR_INFO s;
SELECT * FROM ES_SENSOR_INFO;
EOF