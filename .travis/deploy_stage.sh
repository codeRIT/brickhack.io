eval "$(ssh-agent -s)" # start the ssh agent
openssl aes-256-cbc -K $encrypted_fb724e9ad24a_key -iv $encrypted_fb724e9ad24a_iv -in .travis/marketing_rsa.enc -out .travis/marketing_rsa -d
chmod 600 .travis/marketing_rsa # this key should have push access
ssh-add .travis/marketing_rsa
git remote add deploy dokku@csh-cloud.oweb.co:brickhack-stage
git push --force deploy develop:master
