#!/bin/bash
echo "Backend Deployment"

cd /home/metlife-backend/deployments

source metlife-env/bin/activate
cd metlife_poc 

python manage.py migrate

sudo systemctl stop metlife-api.service

sudo systemctl start metlife-api.service



