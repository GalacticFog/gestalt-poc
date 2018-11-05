#!/bin/bash
# Fail on any error
set -e

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
fog context set --path /root

# Create User Groups
create group-dev
create group-qa
create group-compliance

# Create Users
create user-1-dev
create user-2-qa
create user-3-compliance

# User / Group assignments
fog admin add-user-to-group --group devs --user user1

fog admin add-user-to-group --group qa --user user2

fog admin add-user-to-group --group compliance --user user3
