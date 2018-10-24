#!/bin/bash
set -e

. poc.env
if [ $? -ne 0 ]; then
  echo "Error, aborting"
  exit 1
fi

cat << EOF > sample-ecs-provider.json
{
    "description": "ECS Provider",
    "name": "sample-ecs-provider",
    "properties": {
        "config": {
            "access_key": "#{Config ecs_access_key}",
            "auth": {},
            "cluster": "#{Config ecs_cluster}",
            "endpoints": [
            ],
            "env": {
                "private": {},
                "public": {}
            },
            "external_protocol": "https",
            "networks": [
                "none",
                "bridge",
                "host"
            ],
            "region": "#{Config ecs_region}",
            "secret_key": "#{Config ecs_secret_key}",
            "taskRoleArn": "#{Config ecs_role}",
            "kongConfigureUrl": "#{Config kongConfigureUrl}",
            "kongManagementUrl": "#{Config kongManagementUrl}",
            "sidecarContainerImageOverride": "#{Config sidecarContainerImageOverride}"
        },
        "environment_types": [],
        "linked_providers": [],
        "provider_subtype": "EC2",
        "services": []
    },
    "resource_type": "Gestalt::Configuration::Provider::CaaS::ECS"
}
EOF
