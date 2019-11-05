#!/bin/bash

/usr/bin/python3.6 /usr/local/bin/tensorboard --logdir  /opt/DataTachyonPlatform/businesslayer/ai/deep-learning/tensorboard/scripts/logs/gradient_tape  --port=8008  &

ps -ef | grep tensorboard