#!/bin/bash

set -e

user=$1

# Training org / workspace / environments
fog admin apply-entitlements --user $user -f entitlements/readonly-org.yaml /root
fog admin apply-entitlements --user $user -f entitlements/readonly-org.yaml /training
fog admin apply-entitlements --user $user -f entitlements/readonly-workspace.yaml /training/demo
fog admin apply-entitlements --user $user -f entitlements/readonly-environment.yaml /training/demo/lambda_chaining
fog admin apply-entitlements --user $user -f entitlements/readonly-environment.yaml /training/demo/lambda_demo
fog admin apply-entitlements --user $user -f entitlements/readonly-environment.yaml /training/demo/async_lambdas
fog admin apply-entitlements --user $user -f entitlements/readonly-environment.yaml /training/demo/periodic_lambdas

# User
fog admin apply-entitlements --user $user -f entitlements/readonly-workspace.yaml /training/${user,,}
fog admin apply-entitlements --user $user -f entitlements/developer-dev-environment.yaml /training/${user,,}/local
