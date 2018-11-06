#!/bin/bash

set -e

org='sandbox'
workspace='dev-sandbox'
environment='dev'
kong='default-kong'
laser='default-laser'
api='dev-sandbox'
caas='default-kubernetes'


## ----------------------------------------
## Set up Gestalt Hierarchy
## ----------------------------------------

fog create org --name $org --description 'Sandboxes' --org root
## Admin Sandbox and environments

fog create workspace --org $org --name 'admin-sandbox' -d 'Admin Sandbox'
fog create environment --org $org --workspace 'admin-sandbox' --name 'dev' --description 'Development' --type 'development'
fog create environment --org $org --workspace 'admin-sandbox' --name 'test' --description 'Test' --type 'test'


## Developer Sandbox and envrionments

fog create workspace --org $org --name $workspace -d 'Developer Sandbox'
fog create environment --org $org --workspace $workspace --name 'dev' --description 'Development' --type 'development'
fog create environment --org $org --workspace $workspace --name 'test' --description 'Test' --type 'test'

## ----------------------------------------
## Download and Import Sample Resources
## ----------------------------------------


echo
echo "Creating Sample resources in Sandbox environment..."
echo

# Set context
fog context set /$org/$workspace/$environment

# Create API
fog create api --name $api --description 'Developer Sandbox API' --provider $kong

# Create Containers
fog create resource -f nginx-container.json --provider $caas

## Kafka

fog ext create-sample-resources --dir . --provider $caas --laser-provider $laser --stream-provider 'default-stream-provider'
# fog create resource -f kafka-container.json --provider $caas
# fog create resource -f kafka-consumer-lambda.json --provider $laser
# fog create resource -f kafka-producer-lambda.json --provider $laser
fog create api-endpoint -f kafka-consumer-api-endpoint.json --api $api --lambda 'kafkaConsumer'
fog create api-endpoint -f kafka-producer-api-endpoint.json --api $api --lambda 'kafkaProducer'


# # Create Lambdas

#TIME: 1m1
# fog create resource -f dotnet-hello-lambda.json --provider $laser
# fog create resource -f factorial-lambda.json --provider $laser
# fog create resource -f hello-lodash-lambda.json --provider $laser
# fog create resource -f nashorn-hello-lambda.json --provider $laser
# fog create resource -f periodic-lambda.json --provider $laser
# fog create resource -f python2-hello-lambda.json --provider $laser
# fog create resource -f python3-hello-lambda.json --provider $laser
# fog create resource -f sales-lambda.json --provider $laser
# fog create resource -f slack-sales-lambda.json --provider $laser
# fog create resource -f sms-hello-lambda.json --provider $laser

# time 42s
fog create resource -f dotnet-hello-lambda.json
fog create resource -f factorial-lambda.json
fog create resource -f hello-lodash-lambda.json
fog create resource -f nashorn-hello-lambda.json
fog create resource -f periodic-lambda.json
fog create resource -f python2-hello-lambda.json
fog create resource -f python3-hello-lambda.json
fog create resource -f sales-lambda.json
fog create resource -f slack-sales-lambda.json
fog create resource -f sms-hello-lambda.json


#TIME: 38
# fog create resources \
#     dotnet-hello-lambda.json \
#     factorial-lambda.json \
#     hello-lodash-lambda.json \
#     nashorn-hello-lambda.json \
#     periodic-lambda.json \
#     python2-hello-lambda.json \
#     python3-hello-lambda.json \
#     sales-lambda.json \
#     slack-sales-lambda.json \
#     sms-hello-lambda.json


# ## Hello lambda API endpoints

fog create api-endpoint -f dotnet-hello-api-endpoint.json --api $api --lambda 'dotnet-hello'
fog create api-endpoint -f nashorn-hello-api-endpoint.json --api $api --lambda 'nashorn-hello'
fog create api-endpoint -f hello-lodash-api-endpoint.json --api $api --lambda 'hello-lodash'
fog create api-endpoint -f python2-hello-api-endpoint.json --api $api --lambda 'python2-hello'
fog create api-endpoint -f python3-hello-api-endpoint.json --api $api --lambda 'python3-hello'

# ## Other Examples

fog create api-endpoint -f factorial-api-endpoint.json --api $api --lambda 'factorial'
fog create api-endpoint -f sales-api-endpoint.json --api $api --lambda 'sales'
fog create api-endpoint -f slack-sales-api-endpoint.json --api $api --lambda 'slack-sales'
fog create api-endpoint -f sms-hello-api-endpoint.json --api $api --lambda 'sms-hello'


