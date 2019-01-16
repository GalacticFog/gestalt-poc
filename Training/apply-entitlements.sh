#!/bin/bash

set -e

for user in `cat ../../all-users.txt`; do 
    echo "Applying entitlements for $user ..."

    # Training org / workspace / environments
    # fog admin apply-entitlements --user $user -f entitlements/readonly-org.yaml /root
    fog admin apply-entitlements --user $user -f ../entitlements/readonly-org.yaml /training

    # User
    # fog admin apply-entitlements --user $user -f ../entitlements/readonly-workspace.yaml /training/${user,,}
    fog admin apply-entitlements --user $user -f ../entitlements/developer-dev-environment.yaml /training/${user,,}/local

done