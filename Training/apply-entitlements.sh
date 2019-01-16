#!/bin/bash

set -e

time for user in `cat ../../all-users.txt`; do 
    echo "Applying entitlements for $user ..."

    # Training org / workspace / environments
    # fog admin apply-entitlements --user $user -f entitlements/readonly-org.yaml /root
    time fog admin apply-entitlements --user $user -f ../entitlements/readonly-org.yaml /training

    # User
    # fog admin apply-entitlements --user $user -f ../entitlements/readonly-workspace.yaml /training/${user,,}
    time fog admin apply-entitlements --user $user -f ../entitlements/developer-dev-environment.yaml /training/${user,,}/local

done