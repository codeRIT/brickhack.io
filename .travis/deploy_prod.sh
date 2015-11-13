eval "$(ssh-agent -s)" # start the ssh agent
openssl aes-256-cbc -K $encrypted_60565ecba2d1_key -iv $encrypted_60565ecba2d1_iv -in .travis/marketing_rsa.enc -out .travis/marketing_rsa -d
chmod 600 .travis/marketing_rsa # this key should have push access
ssh-add .travis/marketing_rsa
git remote add deploy dokku@csh-cloud.oweb.co:brickhack-prod
git push --force deploy master:master
bash .travis/post_deploy.sh
