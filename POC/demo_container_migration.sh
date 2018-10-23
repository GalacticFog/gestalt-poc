## Demo Container migration
fog context set /sandbox/dev-sandbox/dev

fog delete container nginx3

fog create resource -f test-container.json

fog migrate container nginx3  /root/cluster1-ecs-with-keys

fog show containers
