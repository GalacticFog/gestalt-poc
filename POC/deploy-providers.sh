#!/bin/bash
# Fail on any error
set -e

DEBUG_FLAG="--debug"
DEBUG_FLAG=

create() {
  local file=$1.json
  echo "Creating resource from '$file'..."
  fog create resource -f $file --config config.yaml
  if [ $? -ne 0 ]; then
    echo "Error: Error processing '$file', aborting."
    exit 1
  fi
}

exit_on_error() {
  if [ $? -ne 0 ]; then
    echo
    echo "[Error] $@"
    exit 1
  fi
}

#Create Providers under Sample Org
fog context set --org 'poc-sample-org'
exit_on_error "Failed to set context, aborting."

create ecs-root-all
exit_on_error "Provider creation failed, aborting."

create ecs-root-only-test
exit_on_error "Provider creation failed, aborting."

# Set context and Create Provider at particular environment
fog context set --org 'poc-sample-org' --workspace 'poc-sample-ws' --environment 'env-dev'
exit_on_error "Failed to set context, aborting."
create ecs-only-specific
exit_on_error "Provider creation failed, aborting."

# -root (OR OTHER)
# -- o:poc-sample-org - POC Sample Organization <=== p: poc-sample-ecs-sample-all (NO CONSTRAINTS), p:poc-sample-ecs-sample-only-test (TEST)
# ---- w: poc-sample-ws - POC Sample Workspace
# ------- e: env-dev - Development Environment (DEV) <=== p: poc-sample-ecs-sample-only-specific
# ------- e: env-int - Integration Environment (TEST)
# ------- e: env-perf - Performance Testing Environment (TEST)
# ------- e: prod - Production Environment (PROD)