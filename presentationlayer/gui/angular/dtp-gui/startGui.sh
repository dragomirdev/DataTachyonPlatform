#!/bin/bash
clear

#npm install
ps -ef | grep 'dtp-gui'
#kill -9 $(lsof -i:4444 -t) 2> /dev/null
ps aux | grep 'dtp-gui' | awk '{print $2}'  | xargs sudo kill -9

npm run start

