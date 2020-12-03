git remote add deploy dokku@csh-cloud.oweb.co:brickhack-stage
git fetch --unshallow
git push --force deploy develop:master
