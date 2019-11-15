#!/bin/bash


export PYSPARK_PYTHON=/usr/bin/python3.6
export PYSPARK_DRIVER_PYTHON=/usr/bin/python3.6
export PYSPARK_DRIVER_PYTHON_OPTS=
clear

default_input_date="$(date +'%Y%m%d')"
input_date=${1:-${default_input_date}}
default_input_path="/data/dtp/landing/iAuditor"
input_path=${2:-${default_input_path}}/$input_date/*
default_output_path="/data/dtp/processed/iAuditor"
target_path=${3:-${default_output_path}}

LANDING_FOLDER=$input_path
PROCESSED_FOLDER=$target_path
HDFS_LIST_CMD="hdfs dfs -ls $LANDING_FOLDER"

echo "Started Processing   from Landing Folder:"$LANDING_FOLDER " to Processed Folder:"$PROCESSED_FOLDER

RUN_SPARK_JOB="spark-submit --master spark://JP-DTP-SPARK-MASTER-VM:7077 ProcessiAuditorInspections.py $input_date $LANDING_FOLDER $PROCESSED_FOLDER --executor-memory 3g --executor-cores=3 --num-executors 3   --conf spark.dynamicAllocation.enabled=false "

$RUN_SPARK_JOB

#$HDFS_LIST_CMD | while read f; do
#  echo $f
#  hdfs_file_name_path=`echo $f  | awk '{print $8}'`;
#  echo "hdfs_file_name_path:"$hdfs_file_name_path
#
#if [ -n "$hdfs_file_name_path" ]; then
#	hdfs_input_file_name="${hdfs_file_name_path##*/}"
#	spark-submit --master spark://JP-DTP-SPARK-MASTER-VM:7077 ProcessiAuditorInspections.py $hdfs_file_name_path $hdfs_input_file_name   --executor-memory 3g --executor-cores=3 --num-executors 3   --conf spark.dynamicAllocation.enabled=false
#
#fi
#
#done
