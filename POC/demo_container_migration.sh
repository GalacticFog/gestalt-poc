## Demo Container migration

fog context set /poc/sample/dev

fog delete container nginx-test

fog apply -f containers/test-container.json --name nginx-test

fog show containers

fog migrate container nginx-test /root/default-ecs-provider

sleep 5

fog show containers
