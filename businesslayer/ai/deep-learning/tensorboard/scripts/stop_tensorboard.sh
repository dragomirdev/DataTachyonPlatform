#!/bin/bash

######################### Stopping TensorBoard###################################
pkill -f tensorboard

sudo systemctl stop tensorboard

ps -ef | pgrep -f "tensorboard" | xargs kill -9

ps -ef | grep tensorboard

