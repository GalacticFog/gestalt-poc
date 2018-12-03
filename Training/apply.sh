#!/bin/bash -x

set -e

# fog meta POST '/migrate?version=V23'

echo "Training Org"
fog apply -f setup/training-org.yaml

echo "Demo Workspace"
fog apply -d setup/demo_workspace

echo "System Workspace"
fog apply -d system_workspace

echo "Demo Environments"
fog apply -d demo_environments --context /training/demo

echo "Lambda demos"
fog apply -d lambda_demo  --context /training/demo/lambda_demo --params api=demo-lambda-demo

echo "Lambda chaining"
fog apply -d lambda_chaining  --context /training/demo/lambda_chaining --params api=demo-lambda-chaining

echo "Periodic lambdas"
fog apply -d periodic_lambdas  --context /training/demo/periodic_lambdas

echo "Async lambdas"
fog apply -d async_lambdas  --context /training/demo/async_lambdas --params api=demo-async-lambdas


echo "Laser support services"
fog apply -d laser_support_services --context /training/system/laser_support_services