#!/bin/bash
echo "Backend Deployment"

cd /home/metlife-backend/deployments

source metlife-env/bin/activate
cd metlife_poc 

sudo systemctl stop metlife-api.service




