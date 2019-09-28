#!/bin/bash

clear

pwd
current_date=$(date '+%Y-%m-%d')

echo "Running Tensorboard for Model Fit Type on" $current_date
tensorboard --logdir logs/fit &

TARGET_HDFS_PROCESSED_FOLDER=/data/dtp/processed/mnist/model-fit-type/ingestiondate=$current_date

echo "Pushing to the HDFS Process Folder" $TARGET_HDFS_PROCESSED_FOLDER
hdfs dfs -mkdir -p $TARGET_HDFS_PROCESSED_FOLDER
hdfs dfs -put logs $TARGET_HDFS_PROCESSED_FOLDER


