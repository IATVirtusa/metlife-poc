#!/bin/bash

if [ -d "bandit-env" ] 
then
    echo "Python bandit virtual environment exists." 
else
    python3 -m venv bandit-env
fi

source bandit-env/bin/activate

pip3 install bandit

bandit -r ./
