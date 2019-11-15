#!/bin/bash

echo "************ Refreshing Hive Tables*********"
hive --service beeline << EOF
!connect jdbc:hive2://10.0.4.10:10000 hadoop hadoop
show databases;
USE dtprriauditordb;
show tables;
DESC RR_IAUDITOR_INSPECTION_REPORT;
MSCK REPAIR TABLE RR_IAUDITOR_INSPECTION_REPORT;
SELECT * FROM RR_IAUDITOR_INSPECTION_REPORT;
desc RR_ES_IAUDITOR_INSPECTION_REPORT;
INSERT OVERWRITE TABLE  RR_ES_IAUDITOR_INSPECTION_REPORT   SELECT *  FROM RR_IAUDITOR_INSPECTION_REPORT s;
SELECT * FROM RR_ES_IAUDITOR_INSPECTION_REPORT;
EOF