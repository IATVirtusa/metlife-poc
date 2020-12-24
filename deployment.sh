echo "Backend Deployment"

cd /home/metlife-backend/deployments

source metlife-env/bin/activate
cd metlife_poc 

python manage.py migrate

systemctl stop metlife-api.service

systemctl start metlife-api.service



