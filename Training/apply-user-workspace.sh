#!/bin/bash

set -e

user=$1

echo "Creating workspace for $i"

fog apply -d student_workspace --params user=$user user_lowercase=${user,,}
fog apply -d student_workspace/env --context /training/${user,,}/local

# fog apply -d student_workspace --params user=$user user_lowercase=${user}
# fog apply -d student_workspace/env --context /training/${user}/local