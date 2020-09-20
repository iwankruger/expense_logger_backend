#!/bin/bash

# example run command
# ./login_first.sh us-east-1_user_pool_id cognito_client_id my@email.com temp_password new_password

USERPOOLID=$1
CLIENT_ID=$2
USERNAME=$3
PASSWORD=$4
PASSWORD_NEW=$5

# Do an initial login
# It will come back wtih a challenge response
AUTH_CHALLENGE_SESSION=`aws cognito-idp initiate-auth \
--auth-flow USER_PASSWORD_AUTH \
--auth-parameters "USERNAME=$USERNAME,PASSWORD=$PASSWORD" \
--client-id $CLIENT_ID \
--query "Session" \
--output text \
--region us-east-1`

# Then respond to the challenge
AUTH_TOKEN=`aws cognito-idp admin-respond-to-auth-challenge \
--user-pool-id $USERPOOLID \
--client-id $CLIENT_ID \
--challenge-responses "NEW_PASSWORD=$PASSWORD_NEW,USERNAME=$USERNAME" \
--challenge-name NEW_PASSWORD_REQUIRED \
--session $AUTH_CHALLENGE_SESSION \
--query "AuthenticationResult.IdToken" \
--output text \
--region us-east-1`

# Tell the world
echo "Changed the password to $PASSWORD_NEW"

echo "Logged in ID Auth Token: "
echo $AUTH_TOKEN

