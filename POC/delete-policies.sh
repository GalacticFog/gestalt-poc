#!/bin/bash

# Fail on any error
# set -e

. poc.env
if [ $? -ne 0 ]; then
  echo "Error, aborting"
  exit 1
fi


# Delete policies
for e in $gestalt_environments_to_apply_policies; do
    echo
    echo "Deleting policies for environment '$e'"
    echo

    fog context set $e
    [ $? -ne 0 ] && exit 1

    fog delete policy default-policy --force
done

# Delete lambdas

fog context set $gestalt_environment_for_policy_lambdas
[ $? -ne 0 ] && exit 1

fog delete lambda container-migrate --force
fog delete lambda container-promote --force
