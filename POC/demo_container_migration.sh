## Demo Container migration

fog context set /poc/sample/dev

fog delete container nginx-test

fog create resource -f test-container.json

fog migrate container nginx-test  /poc/poc-sample-ecs-sample-all

fog show containers
