bash pre_deploy.sh
ENVIRONMENT="production"
git remote add deploy dokku@csh-cloud.oweb.co:brickhack-prod
git push deploy
bash post_deploy.sh
