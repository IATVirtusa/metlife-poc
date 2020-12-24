#!/bin/bash
echo "Backend Deployment"

cd /home/metlife-backend/deployments

source metlife-env/bin/activate
cd metlife_poc 

python manage.py migrate

sudo systemctl stop metlife-api.service
sudo systemctl daemon-reload

sudo systemctl start metlife-api.service

echo "metlife-api.service has started."

sudo systemctl status metlife-api.service




