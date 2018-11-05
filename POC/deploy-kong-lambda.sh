#!/bin/bash

# Fail on any error
set -e

. poc.env
if [ $? -ne 0 ]; then
  echo "Error, aborting"
  exit 1
fi

# Create lambdas
fog context set ${gestalt_environment_for_policy_lambdas}

fog create resource -f update-kong-lambda.json

fog create api 'kong' --description 'Kong Management API' --provider 'default-kong'

fog create api-endpoint -f update-kong-api-endpoint.json --api 'kong' --lambda 'update-kong'

