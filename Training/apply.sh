#!/bin/bash

set -e

# fog meta POST '/migrate?version=V23'

echo "Creating Training Org"
fog apply -f setup/training-org.yaml

echo "Creating Demo Workspace"
fog apply -d setup/demo_workspace

org=training

echo "Creating lambda_demo environment"
fog apply -f lambda_demo/env.yaml  --context /$org/demo
fog apply -d lambda_demo  --context /$org/demo/lambda_demo --params api=demo-lambda-demo

echo "Creating lambda_chaining environment"
fog apply -f lambda_chaining/env.yaml  --context /$org/demo
fog apply -d lambda_chaining  --context /$org/demo/lambda_chaining --params api=demo-lambda-chaining

