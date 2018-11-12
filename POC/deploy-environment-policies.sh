#!/bin/bash

# Fail on any error
set -e

. poc.env
if [ $? -ne 0 ]; then
  echo "Error, aborting"
  exit 1
fi

# Create policies

for e in $gestalt_environments_to_apply_policies; do
    echo
    echo "Creating policies for environment '$e'"
    echo

    fog context set $e
    [ $? -ne 0 ] && exit 1

    fog apply -f policies/policy.json --name 'default-policy'
    fog create policy-rule -f policies/container-migrate-policy-rule.json --policy 'default-policy'
    fog create policy-rule -f policies/container-promote-policy-rule.json --policy 'default-policy'

done
