run() {
    echo "Running '$1...'"
    ./$1
    echo done.
    echo
}

run build-kong-ecs-provider.sh*
run build-lambdas.sh*
run build-policy-rules.sh*
run build-sample-ecs-provider.sh*
run build-sample-resources.sh*