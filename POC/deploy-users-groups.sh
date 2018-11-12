#!/bin/bash
# Fail on any error
set -e

# Set Parent Path
fog context set --path /root

# Create User Groups
fog apply -f groups/dev.yaml
fog apply -f groups/qa.yaml
fog apply -f groups/compliance.yaml

# Create Users
fog apply -f users/user1.yaml
fog apply -f users/user2.yaml
fog apply -f users/user3.yaml

# User / Group assignments
fog admin add-user-to-group --group devs --user user1
fog admin add-user-to-group --group qa --user user2
fog admin add-user-to-group --group compliance --user user3
