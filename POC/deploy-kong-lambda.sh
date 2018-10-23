#!/bin/bash

# Fail on any error
set -e

# Create lambdas
fog context set /root/poc/global

fog create resource -f update-kong-lambda.json

fog create api --name 'kong' --description 'Kong Management API' --provider 'default-kong'

fog create api-endpoint -f update-kong-api-endpoint.json --api 'kong' --lambda 'update-kong'

