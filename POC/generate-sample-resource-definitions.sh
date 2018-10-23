#!/bin/bash
set -e

create_group () {

GROUP_DEFINITION="group-dev.json"
cat << GROUPDEF > ${GROUP_DEFINITION}
{
    "description": "Sample User Group: Developers",
    "name": "group-devs",
    "resource_type": "Gestalt::Resource::Group"
}
GROUPDEF

GROUP_DEFINITION="group-qa.json"
cat << GROUPDEF > ${GROUP_DEFINITION}
{
    "description": "Sample User Group: QA",
    "name": "group-qa",
    "resource_type": "Gestalt::Resource::Group"
}
GROUPDEF

GROUP_DEFINITION="group-compliance.json"
cat << GROUPDEF > ${GROUP_DEFINITION}
{
    "description": "Sample User Group: Compliance",
    "name": "group-compliance",
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
        "gestalt_home": "poc-sample-org",
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
        "gestalt_home": "poc-sample-org",
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
        "gestalt_home": "poc-sample-org",
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

create_group
create_user
create_provider_ecs