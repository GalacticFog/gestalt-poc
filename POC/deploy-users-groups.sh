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

# Set Parent Path
fog context set --path /root ${DEBUG_FLAG}
exit_on_error "Root Context Set failed, aborting."

# Create User Groups
create group-dev
exit_on_error "User Group creation failed, aborting."

create group-qa
exit_on_error "User Group creation failed, aborting."

create group-compliance
exit_on_error "User Group creation failed, aborting."

# Create Users
create user-1-dev
exit_on_error "User creation failed, aborting."

create user-2-qa
exit_on_error "User creation failed, aborting."

create user-3-compliance
exit_on_error "User creation failed, aborting."
