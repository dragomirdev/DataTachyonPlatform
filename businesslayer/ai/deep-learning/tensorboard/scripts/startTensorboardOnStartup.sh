#!/bin/bash

/usr/bin/python3.6 /usr/local/bin/tensorboard --logdir --port=8008 /opt/DataTachyonPlatform/businesslayer/ai/deep-learning/tensorboard/scripts/logs/gradient_tape &

ps -ef | grep tensorboard