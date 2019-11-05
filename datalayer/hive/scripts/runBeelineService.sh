#!/bin/bash

echo "************ Starting Beeline Service*********"
hive --service beeline  << EOF
!connect jdbc:hive2://10.0.4.10:10000 hadoop hadoop
show databases;
show tables;
EOF