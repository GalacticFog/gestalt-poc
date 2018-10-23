cat > container-migrate-lambda.json <<EOF
{
    "resource_type": "Gestalt::Resource::Node::Lambda",
    "name": "container-migrate",
    "description": "Container Migration Lambda",
    "properties": {
        "env": {
            "IMAGE_PREFIX_KUBE": "docker.io",
            "IMAGE_PREFIX_ECS": "my.private.registry",
            "ASSIGN_IMAGE_PREFIX": "true",
            "META_URL": "http://gestalt-meta.gestalt-system:10131",
            "API_KEY": "15c0bcd4-641e-4807-97f0-16e8afa40858",
            "API_SECRET": "m6g3BMz3jKrk7SMnp0rEPgKh2k04VNy9Ured/N3E"
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

cat > container-promote-lambda.json <<EOF
{
    "resource_type": "Gestalt::Resource::Node::Lambda",
    "name": "container-promote",
    "description": "Container Migration Lambda",
    "properties": {
        "env": {
            "META_URL": "http://gestalt-meta.gestalt-system:10131",
            "API_KEY": "15c0bcd4-641e-4807-97f0-16e8afa40858",
            "API_SECRET": "m6g3BMz3jKrk7SMnp0rEPgKh2k04VNy9Ured/N3E"
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
