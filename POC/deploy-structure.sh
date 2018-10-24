#!/bin/bash
# Fail on any error
set -e

# Debug
# fog config set debug=true

exit_on_error() {
  if [ $? -ne 0 ]; then
    echo
    echo "[Error] $@"
    exit 1
  fi
}

. poc.env

# Set Parent Path
fog context set /root
exit_on_error "Root Context Set failed, aborting."

fog create workspace --org root --name global -d 'global' 
fog create environment --org root --workspace global --name 'global' --description 'global' --type 'production'


# Create Organizational Units
# Organization
fog create org --name $org --description 'POC Sample Organization' --org root
exit_on_error "Organization creation failed, aborting."

# Workspace
fog create workspace --org $org --name $workspace -d 'POC Sample Workspace' 
exit_on_error "Workspace creation failed, aborting."

# Environment(-s)
fog create environment --org $org --workspace $workspace --name 'dev' --description 'Development Environment' --type 'development'
exit_on_error "Environment creation failed, aborting."

fog create environment --org $org --workspace $workspace --name 'test' --description 'Integration Environment' --type 'test'
exit_on_error "Environment creation failed, aborting."

fog create environment --org $org --workspace $workspace --name 'perf' --description 'Performance Testing Environment' --type 'test'
exit_on_error "Environment creation failed, aborting."

fog create environment --org $org --workspace $workspace --name 'prod' --description 'Production Environment' --type 'production'
exit_on_error "Environment creation failed, aborting."
