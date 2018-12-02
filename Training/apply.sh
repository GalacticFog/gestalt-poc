#!/bin/bash

students="01"

# for i in $students ; do
#     fog apply -d setup/workspace_template --params student_id=$i
# done

for i in $students ; do
    fog apply -f lambda_demo/env.yaml  --context /training/student-$i --params student_id=$i
    fog apply -d lambda_demo  --context /training/student-$i/lambda_demo --params api=student-$i-lambda-demo student_id=$i
done

# for i in $students ; do
#     fog apply -d lambda_chaining  --context /training/student-$i/local --params api=student-$i-local env=lambda_chaining
# done

