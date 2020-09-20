#!/bin/bash

# example run command
# ./login.sh cognito_client_id my@email.com password

CLIENT_ID=$1
USERNAME=$2
PASSWORD=$3

aws cognito-idp initiate-auth \
--auth-flow USER_PASSWORD_AUTH \
--auth-parameters "USERNAME=$USERNAME,PASSWORD=$PASSWORD" \
--client-id $CLIENT_ID \
--region us-east-1
