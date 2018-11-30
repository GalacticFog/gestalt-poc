#!/bin/bash

# Fail on any error
set -e

. poc.env
if [ $? -ne 0 ]; then
  echo "Error, aborting"
  exit 1
fi

# Create lambdas
fog context set $gestalt_environment_for_policy_lambdas
[ $? -ne 0 ] && exit 1

fog apply -f lambdas/container-migrate-lambda.json
fog apply -f lambdas/container-promote-lambda.json
