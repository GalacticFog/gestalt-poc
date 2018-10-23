#!/bin/bash
# Fail on any error
set -e

DEBUG_FLAG="--debug"
DEBUG_FLAG=

exit_on_error() {
  if [ $? -ne 0 ]; then
    echo
    echo "[Error] $@"
    exit 1
  fi
}

# Set Parent Path
fog context set --path /root ${DEBUG_FLAG}
exit_on_error "Root Context Set failed, aborting."

# Create Organizational Units
# Organization
fog create org --name 'poc-sample-org' --description 'POC Sample Organization' --org root ${DEBUG_FLAG}
exit_on_error "Organization creation failed, aborting."
# Workspace
fog create workspace --org 'poc-sample-org' --name 'poc-sample-ws' -d 'POC Sample Workspace' ${DEBUG_FLAG}
exit_on_error "Workspace creation failed, aborting."
# Environment(-s)
fog create environment --org 'poc-sample-org' --workspace 'poc-sample-ws' --name 'env-dev' --description 'Development Environment' --type 'development' ${DEBUG_FLAG}
exit_on_error "Environment creation failed, aborting."
fog create environment --org 'poc-sample-org' --workspace 'poc-sample-ws' --name 'env-int' --description 'Integration Environment' --type 'test' ${DEBUG_FLAG}
exit_on_error "Environment creation failed, aborting."
fog create environment --org 'poc-sample-org' --workspace 'poc-sample-ws' --name 'env-perf' --description 'Performance Testing Environment' --type 'test' ${DEBUG_FLAG}
exit_on_error "Environment creation failed, aborting."
fog create environment --org 'poc-sample-org' --workspace 'poc-sample-ws' --name 'prod' --description 'Production Environment' --type 'production' ${DEBUG_FLAG}
exit_on_error "Environment creation failed, aborting."
