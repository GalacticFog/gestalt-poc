. poc.env
if [ $? -ne 0 ]; then
  echo "Error, aborting"
  exit 1
fi


cat > container-migrate-lambda.json <<EOF
{
    "resource_type": "Gestalt::Resource::Node::Lambda",
    "name": "container-migrate",
    "description": "Container Migration Lambda",
    "properties": {
        "env": {
            "IMAGE_PREFIX_KUBE": "${registry_kube}",
            "IMAGE_PREFIX_ECS": "${registry_ecs}",
            "ASSIGN_IMAGE_PREFIX": "true",
            "META_URL": "http://gestalt-meta.gestalt-system:10131",
            "API_KEY": "${meta_api_key}",
            "API_SECRET": "${meta_api_secret}"
        },
        "headers": {
            "Accept": "text/plain",
            "Content-Type": "text/plain"
        },
        "code": "`cat src/container-migrate.js | base64`",
        "code_type": "code",
        "cpus": 0.1,
        "memory": 128,
        "timeout": 60,
        "pre_warm": 0,
        "handler": "migrate",
        "public": true,
        "runtime": "nashorn",
        "provider": {
            "id": "#{Provider /root/default-laser id}",
            "locations": []
        },
        "periodic_info": {},
        "secrets": [],
        "apiendpoints": []
    }
}
EOF

echo "Built container-migrate-lambda.json"

cat > container-promote-lambda.json <<EOF
{
    "resource_type": "Gestalt::Resource::Node::Lambda",
    "name": "container-promote",
    "description": "Container Migration Lambda",
    "properties": {
        "env": {
            "META_URL": "http://gestalt-meta.gestalt-system:10131",
            "API_KEY": "${meta_api_key}",
            "API_SECRET": "${meta_api_secret}"
        },
        "headers": {
            "Accept": "text/plain",
            "Content-Type": "text/plain"
        },
        "code": "`cat src/container-promote.js | base64`",
        "code_type": "code",
        "cpus": 0.1,
        "memory": 128,
        "timeout": 60,
        "pre_warm": 0,
        "handler": "promote",
        "public": true,
        "runtime": "nashorn",
        "provider": {
            "id": "#{Provider /root/default-laser id}",
            "locations": []
        },
        "periodic_info": {},
        "secrets": [],
        "apiendpoints": []
    }
}
EOF

echo "Built container-promote-lambda.json" 


cat > sms-lambda.json <<EOF
{
    "resource_type": "Gestalt::Resource::Node::Lambda",
    "name": "sms-notification",
    "description": "SMS Notification Lambda",
    "properties": {
        "env": {
            "phone": "REPLACE WITH PHONE NUMBER",
            "user": "REPLACE",
            "password": "REPLACE"
        },
        "headers": {
            "Accept": "text/plain",
            "Content-Type": "text/html"
        },
        "code": "`cat src/sms-notification.js | base64`",
        "code_type": "code",
        "cpus": 0.1,
        "memory": 128,
        "timeout": 60,
        "pre_warm": 0,
        "handler": "run",
        "public": true,
        "runtime": "nashorn",
        "provider": {
            "id": "#{Provider /root/default-laser id}",
            "locations": []
        },
        "periodic_info": {},
        "secrets": [],
        "apiendpoints": []
    }
}
EOF

echo "Built sms-lambda.json" 


cat > update-kong-lambda.json <<EOF
{
    "name": "update-kong",
    "resource_type": "Gestalt::Resource::Node::Lambda",
    "description": "Lambda for updating Kong endpoints",
    "properties": {
        "apiendpoints": [],
        "provider": {
            "id": "#{Provider /root/default-laser}",
            "locations": []
        },
        "secrets": [],
        "package_url": "http://gestalt-artifacts.gestalt-system.svc.cluster.local/configure-kong.jar",
        "public": true,
        "pre_warm": 0,
        "compressed": false,
        "cpus": 0.1,
        "code_type": "package",
        "headers": {
            "Accept": "text/plain",
            "Content-Type": "text/plain"
        },
        "periodic_info": {},
        "timeout": 60,
        "handler": "com.galacticfog.gestalt.kong.ConfigureForEcs;run",
        "runtime": "java;scala",
        "env": {},
        "memory": 512
    }
}
EOF

echo "Built update-kong-lambda.json" 
