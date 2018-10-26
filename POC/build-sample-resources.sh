#!/bin/bash
set -e

. poc.env
if [ $? -ne 0 ]; then
  echo "Error, aborting"
  exit 1
fi

create_group () {

GROUP_DEFINITION="group-dev.json"
cat << GROUPDEF > ${GROUP_DEFINITION}
{
    "description": "Sample User Group: Developers",
    "name": "devs",
    "resource_type": "Gestalt::Resource::Group"
}
GROUPDEF

GROUP_DEFINITION="group-qa.json"
cat << GROUPDEF > ${GROUP_DEFINITION}
{
    "description": "Sample User Group: QA",
    "name": "qa",
    "resource_type": "Gestalt::Resource::Group"
}
GROUPDEF

GROUP_DEFINITION="group-compliance.json"
cat << GROUPDEF > ${GROUP_DEFINITION}
{
    "description": "Sample User Group: Compliance",
    "name": "compliance",
    "resource_type": "Gestalt::Resource::Group"
}
GROUPDEF

}

create_user () {

USER_DEFINITION="user-1-dev.json"
cat << USERDEF > ${USER_DEFINITION}
{
    "description": "Developer",
    "name": "user1",
    "properties": {
        "email": "user1-dev@poc-sample.gf",
        "firstName": "Developer 1",
        "gestalt_home": "${org}",
        "lastName": "Sample",
        "password": "test123!"
    },
    "resource_type": "Gestalt::Resource::User"
}
USERDEF

USER_DEFINITION="user-2-qa.json"
cat << USERDEF > ${USER_DEFINITION}
{
    "description": "QA",
    "name": "user2",
    "properties": {
        "email": "user-2-qa@poc-sample.gf",
        "firstName": "QA 1",
        "gestalt_home": "${org}",
        "lastName": "Sample",
        "password": "test123!"
    },
    "resource_type": "Gestalt::Resource::User"
}
USERDEF


USER_DEFINITION="user-3-compliance.json"
cat << USERDEF > ${USER_DEFINITION}
{
    "description": "Compliance",
    "name": "user3",
    "properties": {
        "email": "user-3-compl@poc-sample.gf",
        "firstName": "Compliance 1",
        "gestalt_home": "${org}",
        "lastName": "Sample",
        "password": "test123!"
    },
    "resource_type": "Gestalt::Resource::User"
}
USERDEF
}


create_provider_ecs() {

PROVIDER_DEFINITION="ecs-root-all.json"
cat << PROVIDERDEFECS > ${PROVIDER_DEFINITION}
{
    "description": "ECS Provider Available For All",
    "name": "poc-sample-ecs-sample-all",
    "properties": {
        "config": {
            "access_key": "#{Config ecs_access_key}",
            "auth": {},
            "cluster": "#{Config ecs_cluster}",
            "endpoints": [
                {
                    "actions": [
                        "container.import"
                    ],
                    "default": false,
                    "http": {
                        "method": "POST",
                        "url": "https://gtw1.test.galacticfog.com/ecs-container-import/asimport"
                    }
                }
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
PROVIDERDEFECS

PROVIDER_DEFINITION="ecs-root-only-test.json"
cat << PROVIDERDEFECS > ${PROVIDER_DEFINITION}
{
    "description": "ECS Provider available only for Test Type Environments",
    "name": "poc-sample-ecs-sample-only-test",
    "properties": {
        "config": {
            "access_key": "#{Config ecs_access_key}",
            "auth": {},
            "cluster": "#{Config ecs_cluster}",
            "endpoints": [
                {
                    "actions": [
                        "container.import"
                    ],
                    "default": false,
                    "http": {
                        "method": "POST",
                        "url": "https://gtw1.test.galacticfog.com/ecs-container-import/asimport"
                    }
                }
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
            "taskRoleArn": "#{Config ecs_role}"
        },
        "environment_types": ["test"],
        "linked_providers": [],
        "provider_subtype": "EC2",
        "services": []
    },
    "resource_type": "Gestalt::Configuration::Provider::CaaS::ECS"
}
PROVIDERDEFECS


PROVIDER_DEFINITION="ecs-only-specific.json"
cat << PROVIDERDEFECS > ${PROVIDER_DEFINITION}
{
    "description": "ECS Provider Available For Specific Environment",
    "name": "poc-sample-ecs-sample-only-specific",
    "properties": {
        "config": {
            "access_key": "#{Config ecs_access_key}",
            "auth": {},
            "cluster": "#{Config ecs_cluster}",
            "endpoints": [
                {
                    "actions": [
                        "container.import"
                    ],
                    "default": false,
                    "http": {
                        "method": "POST",
                        "url": "https://gtw1.test.galacticfog.com/ecs-container-import/asimport"
                    }
                }
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
            "taskRoleArn": "#{Config ecs_role}"
        },
        "environment_types": [],
        "linked_providers": [],
        "provider_subtype": "EC2",
        "services": []
    },
    "resource_type": "Gestalt::Configuration::Provider::CaaS::ECS"
}
PROVIDERDEFECS
}



cat > test-container.json <<EOF
{
    "resource_type": "Gestalt::Resource::Container",
    "name": "nginx-test",
    "properties": {
        "provider": {
            "properties": {
                "config": {
                    "networks": []
                }
            },
            "id": "#{Provider /root/default-kubernetes id}"
        },
        "env": {},
        "labels": {},
        "port_mappings": [
            {
                "type": "external",
                "protocol": "tcp",
                "expose_endpoint": true,
                "name": "web",
                "lb_port": 80,
                "container_port": 80
            }
        ],
        "volumes": [],
        "secrets": [],
        "health_checks": [],
        "force_pull": false,
        "container_type": "DOCKER",
        "cpus": 0.5,
        "memory": 128,
        "num_instances": 1,
        "image": "nginx",
        "network": "default",
        "accepted_resource_roles": [],
        "constraints": []
    }
}
EOF

echo "Built test-container.json"

create_group
create_user
# create_provider_ecs