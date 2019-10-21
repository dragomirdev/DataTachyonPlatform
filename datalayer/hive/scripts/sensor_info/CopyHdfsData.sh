#!/bin/bash

default_input_date="date +%F"
input_date=${1:-${default_input_date}}

default_source_path=/data/dtp/landing/kafka-logs/$input_date/*
source_data_path=${2:-${default_source_path}}

default_target_path=/data/dtp/processed/kafka-logs/
target_path=${3:-${default_target_path}}

hdfs dfs -cp -f source_data_path  target_path


