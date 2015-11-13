bash pre_deploy.sh
ENVIRONMENT="staging"
git remote add deploy dokku@csh-cloud.oweb.co:brickhack-stage
git push deploy
bash post_deploy.sh
