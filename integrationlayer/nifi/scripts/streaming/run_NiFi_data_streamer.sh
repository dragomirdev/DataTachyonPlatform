#! /bin/bash


default_input_path="/datadrive/dtp/input/kafka-logs"
input_path=${1:-${default_input_path}}
default_output_path="/data/dtp/landing/kafka-logs"
output_path=${2:-${default_output_path}}

default_bkp_path="/datadrive/dtp/backup/kafka-logs"
bkp_path=${3:-${default_bkp_path}}
default_err_path="/datadrive/dtp/error/kafka-logs"
err_path=${4:-${default_err_path}}

echo "input path: ${input_path}"
echo "output path: ${output_path}"
echo "backup path: ${bkp_path}"
echo "error path: ${err_path}"

python3 nifi_data_streamer.py $input_path $output_path $bkp_path $err_path

