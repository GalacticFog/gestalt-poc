#!/bin/bash -x
# Fail on any error
set -e

. poc.env

# Global workspace
fog context set /root
fog create workspace --name global --description 'global' 

# Global environment
fog context set /root/global
fog create environment --name 'global' --description 'global' --type 'production'

# Sample org
fog create org $org --description 'POC Sample Organization' --org root

# Workspace
fog create workspace $workspace --description 'POC Sample Workspace' --org $org

# Environments
fog context set /$org/$workspace
fog create environment --name 'dev'  --description 'Development Environment' --type 'development'
fog create environment --name 'test' --description 'Integration Environment' --type 'test'
fog create environment --name 'perf' --description 'Performance Testing Environment' --type 'test'
fog create environment --name 'prod' --description 'Production Environment' --type 'production'
