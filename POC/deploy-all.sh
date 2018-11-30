run() {
    echo "Running '$@...'"
    $@
    if [ $? -ne 0 ]; then
        echo "$@ encountered an error, aborting."
        exit 1
    fi
    echo done.
    echo
}

. poc.env

run fog context set /root

run fog apply -d users

run fog apply -d groups

run fog apply -d hierarchy

# Apply global resources
run fog apply -d global --context $gestalt_environment_for_policy_lambdas

# Deploy environment policies
for e in $gestalt_environments_to_apply_policies; do
    run fog apply -d policies --context $e
done

# Deploy sample resources
for e in $gestalt_environments_to_apply_policies; do
    run fog apply -d sample-resources --context $e
done