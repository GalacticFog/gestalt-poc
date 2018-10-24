#!/bin/bash

# Fail on any error
set -e

. poc.env
if [ $? -ne 0 ]; then
  echo "Error, aborting"
  exit 1
fi

# Delete lambdas

fog context set $gestalt_environment_for_policy_lambdas
[ $? -ne 0 ] && exit 1

fog delete lambda container-migrate --force
fog delete lambda container-promote --force
