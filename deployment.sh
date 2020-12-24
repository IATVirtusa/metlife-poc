#!/bin/bash
echo "Backend Deployment"

cd /home/metlife-backend/deployments

source metlife-env/bin/activate
cd metlife_poc 

sudo systemctl stop metlife-api.service
sudo systemctl daemon-reload

sudo systemctl start gunicorn

echo "Gunicorn has started."

sudo systemctl enable gunicorn

echo "Gunicorn has been enabled."

sudo systemctl status gunicorn

sudo systemctl restart gunicorn



