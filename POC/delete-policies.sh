#!/bin/bash

# Fail on any error
# set -e

# Delete policies
for e in dev test; do 
    fog context set /sandbox/dev-sandbox/$e
    [ $? -ne 0 ] && exit 1

    fog delete policy default-policy --force
done

# Delete lambdas

fog context set /root/poc/global
[ $? -ne 0 ] && exit 1

fog delete lambda container-migrate --force
fog delete lambda container-promote --force
