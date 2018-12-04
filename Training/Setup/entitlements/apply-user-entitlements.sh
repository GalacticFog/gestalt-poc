#!/bin/bash

set -e

user=$1

# Training org / workspace / environments
fog admin apply-entitlements --user $user -f readonly-org.yaml /root --add-only
fog admin apply-entitlements --user $user -f readonly-org.yaml /training --add-only
fog admin apply-entitlements --user $user -f readonly-workspace.yaml /training/demo --add-only
fog admin apply-entitlements --user $user -f readonly-environment.yaml /training/demo/lambda_chaining --add-only
fog admin apply-entitlements --user $user -f readonly-environment.yaml /training/demo/lambda_demo --add-only
fog admin apply-entitlements --user $user -f readonly-environment.yaml /training/demo/async_lambdas --add-only
fog admin apply-entitlements --user $user -f readonly-environment.yaml /training/demo/periodic_lambdas --add-only


# User
fog admin apply-entitlements --user $user -f readonly-workspace.yaml /training/${user,,} --add-only
fog admin apply-entitlements --user $user -f developer-dev-environment.yaml /training/${user,,}/local --add-only
