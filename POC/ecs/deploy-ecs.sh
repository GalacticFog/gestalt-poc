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

if [ ! -z "$enable_ecs" ]; then 
    run ./deploy-kong-lambda.sh
    run fog context set /root
    run fog apply -f ecs --config ecs/config.yaml
fi
