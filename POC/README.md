## Setup

1. Modify "config.yaml" with your ECS Provider information: ecs_cluster,ecs_access_key,ecs_secret_key
2. (Optional) Modify "deploy-structure.sh" parent context path.
3. Modify generate-lambdas.sh with values for variables
4. Modify ./delete-policies.sh and ./deploy-policies.sh with context paths
5. Modify "cli_login.sh" with proper Gestalt Environment Entry Point: "gestalt_ui_service_url" and export appropriate Fog CLI binary in PATH

## Deployment Order

1. Login: ```./cli_login.sh```
2. Create Structure:  ```./deploy-structure.sh```
3. Create Users and Groups: ```./deploy-users-groups.sh```
4. (Manual) Configure User Group Assignment and Entitlements (can also be done later)
5. Create Providers: ```./deploy-providers.sh```
6. <WHAT ERIC WANTS>

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
