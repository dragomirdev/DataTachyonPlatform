#!/bin/bash


export PYSPARK_PYTHON=/usr/bin/python3.6
export PYSPARK_DRIVER_PYTHON=/usr/bin/python3.6
export PYSPARK_DRIVER_PYTHON_OPTS=
clear

LANDING_FOLDER="/data/dtp/landing/iAuditor/20191112"
PROCESSED_FOLDER="/data/dtp/processed/iAuditor"
HDFS_LIST_CMD="hdfs dfs -ls $LANDING_FOLDER"

echo "Started Processing   from Landing Folder:"$LANDING_FOLDER " to Processed Folder:"$PROCESSED_FOLDER


LOCAL_SPARK_JOB="spark-submit --master spark://JP-DTP-SPARK-MASTER-VM:7077 ProcessiAuditorInspections.py --executor-memory 3g --executor-cores=3 --num-executors 3   --conf spark.dynamicAllocation.enabled=false "


$HDFS_LIST_CMD | while read f; do
  echo $f
  hdfs_file_name_path=`echo $f  | awk '{print $8}'`;
  echo "hdfs_file_name_path:"$hdfs_file_name_path

if [ -n "$hdfs_file_name_path" ]; then
   spark-submit --master spark://JP-DTP-SPARK-MASTER-VM:7077 ProcessiAuditorInspections.py $hdfs_file_name_path  --executor-memory 3g --executor-cores=3 --num-executors 3   --conf spark.dynamicAllocation.enabled=false

fi

done
