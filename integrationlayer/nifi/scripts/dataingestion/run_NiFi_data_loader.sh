#! /bin/bash


default_input_path="/media/nvidia/r2dlssd/data/bip/input/"
input_path=${1:-${default_input_path}}
default_output_path="/data/bip/landing/"
output_path=${2:-${default_output_path}}

default_bkp_path="/media/nvidia/r2dlssd/data/bip/backup/"
bkp_path=${3:-${default_bkp_path}}
default_err_path="/media/nvidia/r2dlssd/data/bip/error/"
err_path=${4:-${default_err_path}}

echo "input path: ${input_path}"
echo "output path: ${output_path}"
echo "backup path: ${bkp_path}"
echo "error path: ${err_path}"

python3 nifi_data_loader.py $input_path $output_path $bkp_path $err_path

