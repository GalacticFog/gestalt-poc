#!/bin/bash

# Fail on any error
set -e

. poc.env

fog context set $gestalt_environment_for_policy_lambdas

set +e

fog delete api --name demo --force

fog delete lambda 'sms-notification'
