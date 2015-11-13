ACCESS_TOKEN=$ROLLBAR_ACCESS_TOKEN
LOCAL_USERNAME="travisci"

if [ $TRAVIS_BRANCH == "develop" ]
then
  ENVIRONMENT=staging
elif [ $TRAVIS_BRANCH == "master" ]
then
  ENVIRONMENT=production
fi

REVISION=$TRAVIS_COMMIT

curl https://api.rollbar.com/api/1/deploy/ \
  -F access_token=$ACCESS_TOKEN \
  -F environment=$ENVIRONMENT \
  -F revision=$REVISION \
  -F local_username=$LOCAL_USERNAME
