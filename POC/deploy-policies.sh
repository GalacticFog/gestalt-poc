#!/bin/bash

# Fail on any error
set -e

# Create lambdas
fog context set /root/poc/global
[ $? -ne 0 ] && exit 1

fog create resource -f container-migrate-lambda.json
fog create resource -f container-promote-lambda.json


# Create policies

for e in dev test; do

    fog context set /sandbox/dev-sandbox/$e
    [ $? -ne 0 ] && exit 1

    fog create resource -f policy.json
    fog create policy-rule -f container-migrate-policy-rule.json --policy 'default-policy'
    fog create policy-rule -f container-promote-policy-rule.json --policy 'default-policy'

done
