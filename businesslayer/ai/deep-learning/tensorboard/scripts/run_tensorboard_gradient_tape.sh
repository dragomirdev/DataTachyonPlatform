#!/bin/bash

clear

# Clear any logs from previous runs
rm -rf ./logs/

echo "Running Tensorboard for the Gradient Type"
tensorboard --logdir logs/gradient_tape &
