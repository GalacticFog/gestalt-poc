## Setup

./cli_login.sh
./get_meta_info.sh

1. Modify "config.yaml" with your ECS Provider information: ecs_cluster,ecs_access_key,ecs_secret_key
2. (Optional) Modify "deploy-structure.sh" parent context path.
3. Modify build-lambdas.sh with values for variables
4. Export appropriate Fog CLI binary in PATH

## Build resources
```
./build-lambdas.sh
./build-policy-rules.sh
./build-kong-ecs-provider.sh
./build-sample-resources.sh
```

## Deployment Order

1. Login: `./cli_login.sh`
2. Create Structure:  `./deploy-structure.sh`
3. Create Users and Groups: `./deploy-users-groups.sh`
4. (Manual) Configure User Group Assignment and Entitlements (can also be done later)
5. Create Providers: `./deploy-providers.sh`

## Deploy Policies
```
./deploy-structure.sh
./deploy-users-groups.sh
./deploy-providers.sh
./deploy-global-resources.sh
./deploy-per-enviornment-resources.sh
./deploy-kong-lambda.sh
./deploy-sms-lambda.sh
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
