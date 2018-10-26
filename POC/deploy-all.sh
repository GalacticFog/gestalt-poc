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

run deploy-structure.sh
run deploy-users-groups.sh
run deploy-global-resources.sh
run deploy-per-enviornment-resources.sh
run deploy-kong-lambda.sh
run deploy-sms-lambda.sh
run deploy-providers.sh
