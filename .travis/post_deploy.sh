ACCESS_TOKEN=$ROLLBAR_ACCESS_TOKEN
LOCAL_USERNAME="Travis CI"

if [ $ENVIRONMENT == "staging" ]
then
  BRANCH=develop
else
  BRANCH=master
fi

REVISION=$TRAVIS_COMMIT

curl https://api.rollbar.com/api/1/deploy/ \
  -F access_token=$ACCESS_TOKEN \
  -F environment=$ENVIRONMENT \
  -F revision=$REVISION \
  -F local_username=$LOCAL_USERNAME
