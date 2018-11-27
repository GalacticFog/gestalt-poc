#!/bin/bash -x
# Fail on any error
set -e

. poc.env

# Workspace
fog context set /root
fog create workspace --name sample-python --description 'sample-python' 
# Environment
fog context set /root/sample-python
fog create environment --name 'dev' --description 'Sample Python Lambdas' --type 'development'


fog context set /root/sample-python/dev

# API
fog create api 'hello' --description 'Sample API' --provider 'default-kong'

# Lambda(-s)
fog create resource -f generated/python-hello-default-lambda.json
fog create resource -f generated/python-hello-3-6-1-lambda.json
fog create resource -f generated/python-hello-3-6-3-lambda.json

# Attach API to Lambda
fog create api-endpoint -f endpoints/hello-python-default-endpoint.json --api 'hello' --lambda 'hello-python-default'
fog create api-endpoint -f endpoints/hello-python-3-6-1-endpoint.json --api 'hello' --lambda 'hello-python-3-6-1'
fog create api-endpoint -f endpoints/hello-python-3-6-3-endpoint.json --api 'hello' --lambda 'hello-python-3-6-3'


