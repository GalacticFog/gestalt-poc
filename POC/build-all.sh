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

if [ ! -z "$enable_ecs" ]; then 
    run build-kong-ecs-provider.sh
    run build-sample-ecs-provider.sh
fi

run build-lambdas.sh
run build-policy-rules.sh
run build-sample-resources.sh