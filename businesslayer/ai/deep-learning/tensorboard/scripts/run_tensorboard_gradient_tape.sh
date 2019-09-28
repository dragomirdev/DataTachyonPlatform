#!/bin/bash

clear

pwd

echo "Running Tensorboard for the Gradient Type"
tensorboard --logdir logs/gradient_tape &
