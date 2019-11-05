#!/bin/bash

clear
pkill -f tensorboard

pwd
current_date=$(date '+%Y-%m-%d')

TARGET_HDFS_PROCESSED_FOLDER=/data/dtp/processed/mnist/

echo "Started Pushing Output logs to the HDFS Process Folder" $TARGET_HDFS_PROCESSED_FOLDER

hdfs dfs -mkdir -p $TARGET_HDFS_PROCESSED_FOLDER
hdfs dfs -put logs $TARGET_HDFS_PROCESSED_FOLDER

echo "Completed Pushing Output logs to the HDFS Process Folder " $TARGET_HDFS_PROCESSED_FOLDER

echo "Running Tensorboard for Model Fit Type on" $current_date
tensorboard --logdir logs/fit   --port=8008 &

