#!/bin/bash

clear

# Clear any logs from previous runs
rm -rf ./logs/

echo "Running Tensorboard for Model Fit Type"
tensorboard --logdir logs/fit
