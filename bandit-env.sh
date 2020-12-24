#!/bin/bash

cd  /home/metlife-backend/deployments/

if [ -d "bandit-env" ] 
then
    echo "Python bandit virtual environment exists." 
else
    python3 -m venv bandit-env
fi

source bandit-env/bin/activate

pip3 install bandit

bandit -f html -o sast_out.html --exit-zero -r /home/lduser/deployments/deployments/metlife_poc/metlife_poc/*.py
