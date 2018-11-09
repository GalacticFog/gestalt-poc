run() {
    echo "Running '$1...'"
    ./$1
    if [ $? -ne 0 ]; then
        echo "$1 encountered an error, aborting."
        exit 1
    fi
    echo done.
    echo
}

. poc.env

run deploy-hierarchy.sh
run deploy-users-groups.sh
run deploy-global-resources.sh
run deploy-environment-policies.sh
run deploy-sms-lambda.sh

if [ ! -z "$enable_ecs" ]; then 
    run deploy-kong-lambda.sh
    run deploy-providers.sh
fi
