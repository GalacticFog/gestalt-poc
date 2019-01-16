#!/bin/bash -x

set -e

fog apply -d demo_workspace --context /root --params org=root

fog apply -d demo_environments --context /root/demo 

fog apply -d url_redirect --context /root/demo/url_redirect --params api=demo-url-redirect --config ../config.yaml

fog apply -d vm_provision --context /root/demo/vm_provision --params api=demo-vm-provision --config ../config.yaml

fog apply -d lambda_demo  --context /root/demo/lambda_demo --params api=demo-lambda-demo --config ../config.yaml

fog apply -d lambda_chaining  --context /root/demo/lambda_chaining --params api=demo-lambda-chaining --config ../config.yaml

fog apply -d periodic_lambdas  --context /root/demo/periodic_lambdas --config ../config.yaml

fog apply -d async_lambdas  --context /root/demo/async_lambdas --params api=demo-async-lambdas --config ../config.yaml



# fog apply -d ui_lambdas --context /root/demo/ui_lambdas --params api=demo-ui-lambdas --config ../config.yaml

#TODO:
# fog apply -d laser_support_services --context /training/system/laser_support_services --config config.yaml