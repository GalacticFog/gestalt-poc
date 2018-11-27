set -e

. poc.env

echo "Reading gestalt-security-creds secret from Kubernetes cluster..."
meta_api_key=`kubectl get secrets -n gestalt-system gestalt-security-creds -ojsonpath='{.data.API_KEY}' | base64 --decode`
meta_api_secret=`kubectl get secrets -n gestalt-system gestalt-security-creds -ojsonpath='{.data.API_SECRET}' | base64 --decode`

if [ -z "$meta_api_key" ]; then
    echo "Missing meta_api_key, aborting"
    exit 1
fi

if [ -z "$meta_api_secret" ]; then
    echo "Missing meta_api_secret, aborting"
    exit 1
fi

mkdir -p generated

cat > generated/container-migrate-lambda.json <<EOF
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

cat > generated/container-promote-lambda.json <<EOF
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


cat > generated/sms-lambda.json <<EOF
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



cat > generated/python-hello-default-lambda.json <<EOF
{
    "resource_type": "Gestalt::Resource::Node::Lambda",
    "description": "Python3 Hello Lambda",
    "name": "hello-python-default",
    "properties": {
        "apiendpoints": [],
        "code_type": "package",
        "compressed": false,
        "cpus": 0.1,
        "env": {},
        "handler": "hello",
        "headers": {
            "Accept": "text/plain",
            "Content-Type": "text/plain"
        },
        "memory": 128,
        "package_url": "https://raw.githubusercontent.com/GalacticFog/lambda-examples/master/python_lambda/hello3.py",
        "periodic_info": {},
        "pre_warm": 0,
        "provider": {
            "id": "#{Provider /root/default-laser id}",
            "locations": []
        },
        "public": true,
        "runtime": "python",
        "secrets": [],
        "timeout": 60
    }
}
EOF

echo "Built python-hello-default-lambda.json" 


cat > generated/python-hello-3-6-1-lambda.json <<EOF
{
    "resource_type": "Gestalt::Resource::Node::Lambda",
    "description": "Python3 Hello Lambda",
    "name": "hello-python-3-6-1",
    "properties": {
        "apiendpoints": [],
        "code_type": "package",
        "compressed": false,
        "cpus": 0.1,
        "env": {},
        "handler": "hello",
        "headers": {
            "Accept": "text/plain",
            "Content-Type": "text/plain"
        },
        "memory": 128,
        "package_url": "https://raw.githubusercontent.com/GalacticFog/lambda-examples/master/python_lambda/hello3.py",
        "periodic_info": {},
        "pre_warm": 0,
        "provider": {
            "id": "#{Provider /root/default-laser id}",
            "locations": []
        },
        "public": true,
        "runtime": "python361",
        "secrets": [],
        "timeout": 60
    }
}
EOF

echo "Built python-hello-3-6-1-lambda.json" 



cat > generated/python-hello-3-6-3-lambda.json <<EOF
{
    "resource_type": "Gestalt::Resource::Node::Lambda",
    "description": "Python3 Hello Lambda",
    "name": "hello-python-3-6-3",
    "properties": {
        "apiendpoints": [],
        "code_type": "package",
        "compressed": false,
        "cpus": 0.1,
        "env": {},
        "handler": "hello",
        "headers": {
            "Accept": "text/plain",
            "Content-Type": "text/plain"
        },
        "memory": 128,
        "package_url": "https://raw.githubusercontent.com/GalacticFog/lambda-examples/master/python_lambda/hello3.py",
        "periodic_info": {},
        "pre_warm": 0,
        "provider": {
            "id": "#{Provider /root/default-laser id}",
            "locations": []
        },
        "public": true,
        "runtime": "python363",
        "secrets": [],
        "timeout": 60
    }
}
EOF

echo "Built python-hello-3-6-3-lambda.json" 