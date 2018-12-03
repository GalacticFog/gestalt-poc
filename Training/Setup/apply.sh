#!/bin/bash -x

set -e

# fog meta POST '/migrate?version=V23'

fog apply -d orgs

fog apply -d demo_workspace

fog apply -d system_workspace

fog apply -d demo_environments --context /training/demo

fog apply -d lambda_demo  --context /training/demo/lambda_demo --params api=demo-lambda-demo

fog apply -d lambda_chaining  --context /training/demo/lambda_chaining --params api=demo-lambda-chaining

fog apply -d periodic_lambdas  --context /training/demo/periodic_lambdas

fog apply -d async_lambdas  --context /training/demo/async_lambdas --params api=demo-async-lambdas

fog apply -d laser_support_services --context /training/system/laser_support_services