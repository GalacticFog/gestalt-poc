. poc.env

mkdir -p generated

cat > generated/policy.json <<EOF
{
    "resource_type": "Gestalt::Resource::Policy",
    "name": "default-policy",
    "description": "Default Environment Policy",
    "properties": {}
}
EOF

cat > generated/container-migrate-policy-rule.json <<EOF
{
    "name": "invoke-container-migrate",
    "description": "Invoke Container Migrate",
    "properties": {
        "match_actions": [
            "container.migrate.pre"
        ],
        "lambda": "#{Lambda ${gestalt_environment_for_policy_lambdas}/container-migrate}"
    },
    "resource_type": "Gestalt::Resource::Rule::Event"
}
EOF

cat > generated/container-promote-policy-rule.json <<EOF
{
    "name": "invoke-container-promote",
    "description": "Invoke Container Promote",
    "properties": {
        "match_actions": [
            "container.promote.pre"
        ],
        "lambda": "#{Lambda ${gestalt_environment_for_policy_lambdas}/container-promote}"
    },
    "resource_type": "Gestalt::Resource::Rule::Event"
}
EOF