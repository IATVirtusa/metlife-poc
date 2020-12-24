#!/bin/bash

if [ -d "metlife-env" ] 
then
    echo "Python virtual environment exists." 
else
    python3 -m venv metlife-env
fi

source metlife-env/bin/activate

pip3 install bandit
pip3 install -r requirements.txt

if [ -d "logs" ] 
then
    echo "Log folder exists." 
else
    mkdir logs
    touch logs/error.log logs/access.log
fi

sudo chmod -R 777 logs
