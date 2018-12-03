#!/bin/bash

set -e

students=$@

for i in $students ; do
    echo "Creating workspace for Student $i"
    fog apply -d student_workspace --params student_id=$i
    fog apply -d student_workspace/env --context /training/student-$i/local
done

