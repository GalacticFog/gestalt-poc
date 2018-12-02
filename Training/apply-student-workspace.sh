#!/bin/bash

set -e

students=$@

for i in $students ; do
    echo "Creating workspace for Student $i"
    fog apply -d setup/student_workspace --params student_id=$i
    fog apply -d setup/student_workspace/env --context /training/student-$i/local

    # echo "Creating lambda_demo environment for Student $i"
    # fog apply -f lambda_demo/env.yaml  --context /training/student-$i
    # fog apply -d lambda_demo  --context /training/student-$i/lambda_demo --params api=student-$i-lambda-demo

    # echo "Creating lambda_chaingin environment for Student $i"
    # fog apply -f lambda_chaining/env.yaml  --context /training/student-$i
    # fog apply -d lambda_chaining  --context /training/student-$i/lambda_chaining --params api=student-$i-lambda-chaining
done

