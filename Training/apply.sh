#!/bin/bash

set -e

echo "Creating Demo Workspace"
fog apply -d setup/demo_workspace

echo "Creating lambda_demo environment for Student 00"
fog apply -f lambda_demo/env.yaml  --context /training/demo
fog apply -d lambda_demo  --context /training/demo/lambda_demo --params api=demo-lambda-demo

echo "Creating lambda_chaingin environment for Student 00"
fog apply -f lambda_chaining/env.yaml  --context /training/demo
fog apply -d lambda_chaining  --context /training/demo/lambda_chaining --params api=demo-lambda-chaining

students=$@

for i in $students ; do
    echo "Creating workspace for Student $i"
    fog apply -d setup/student_workspace --params student_id=$i

    echo "Creating lambda_demo environment for Student $i"
    fog apply -f lambda_demo/env.yaml  --context /training/student-$i
    fog apply -d lambda_demo  --context /training/student-$i/lambda_demo --params api=student-$i-lambda-demo

    echo "Creating lambda_chaingin environment for Student $i"
    fog apply -f lambda_chaining/env.yaml  --context /training/student-$i
    fog apply -d lambda_chaining  --context /training/student-$i/lambda_chaining --params api=student-$i-lambda-chaining
done

