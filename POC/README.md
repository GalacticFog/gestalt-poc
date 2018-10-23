## Setup

1. Modify generate-lambdas.sh with values for variables
2. Modify ./delete-policies.sh and ./deploy-policies.sh with context paths

2.1 Modify "config.yaml" with your ECS Provider information: ecs_cluster,ecs_access_key,ecs_secret_key


## Deploy Policies
```
./generate-lambdas.sh && ./delete-policies.sh && ./deploy-policies.sh
```

## Debugging Migration Policy

```
# tail the js executor logs
kubetail '^js' -n 6f886e73-0993-4b7a-b7c1-4348db3dad77 -e

# Run a container migration
./demo_container_migration.sh

# Show result
fog show containers
```


## Debugging Promotion Policy

```
# tail the js executor logs
kubetail '^js' -n 6f886e73-0993-4b7a-b7c1-4348db3dad77 -e

# Run a container promotion
./demo_container_promotion.sh

# Show result
fog context select-environment

(select the test environment)

fog show containers
```
