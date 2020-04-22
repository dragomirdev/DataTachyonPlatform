#!/bin/bash
source ~/.bash_profile
clear
echo "Stopping Tensorboard Server"
cd /opt/dtp

pyenv deactivate dtpai

ps aux | grep 'tensorboard' | awk '{print $2}'  | xargs kill -9

