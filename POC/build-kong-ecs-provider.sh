. poc.env

mkdir -p generated

cat > generated/kong-ecs-provider.yaml <<EOF
#
# Configuration only Kong provider for an external Kong instance
#
name: kong-ecs-cluster
description: The default gestalt kong provider (External)
resource_type: Gestalt::Configuration::Provider::Kong
properties:
  config:
    env:
      public:
        PUBLIC_URL_HOST: "${kong_host}"
        # PUBLIC_URL_PORT: 8000
        PUBLIC_URL_PROTOCOL: http
        PUBLIC_URL_VHOST_0: "${kong_host}"
        SERVICE_HOST: "${kong_mgmt_host}"
        # SERVICE_PORT: 8001
        SERVICE_PROTOCOL: http

    external_protocol: http
EOF