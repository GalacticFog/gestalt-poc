#!/bin/bash

# Fail on any error
set -e

. poc.env

# Create lambdas
fog context set $gestalt_environment_for_policy_lambdas

fog create resource -f generated/sms-lambda.json

fog create api 'demo' --description 'Demo API' --provider 'default-kong'

fog create api-endpoint -f generated/sms-endpoint.json --api 'demo' --lambda 'sms-notification'
