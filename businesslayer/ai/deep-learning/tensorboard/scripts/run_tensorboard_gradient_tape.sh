#!/bin/bash

clear

pwd

echo "Running Tensorboard for the Gradient Type"
tensorboard --logdir logs/gradient_tape &

hdfs dfs -mkdir -p /data/dtp/processed/mnist/gradient-type/
hdfs dfs -put logs /data/dtp/processed/mnist/gradient-type/


clear

pwd
current_date=$(date '+%Y-%m-%d')

echo "Running Tensorboard for Gradient Type for Date: " $current_date
tensorboard --logdir logs/gradient_tape &

TARGET_HDFS_PROCESSED_FOLDER=/data/dtp/processed/mnist/gradient_tape/ingestiondate=$current_date

echo "Pushing to the HDFS Process Folder" $TARGET_HDFS_PROCESSED_FOLDER

hdfs dfs -mkdir -p $TARGET_HDFS_PROCESSED_FOLDER
hdfs dfs -put logs $TARGET_HDFS_PROCESSED_FOLDER



