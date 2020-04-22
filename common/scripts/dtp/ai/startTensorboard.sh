#!/bin/bash
source ~/.bash_profile

echo "Starting Tensorboard"
cd /opt/ai

pyenv activate dtpai

# python -m tensorflow.tensorboard -–logdir=/opt/ai/logs
tensorboard --logdir=/opt/ai/logs
