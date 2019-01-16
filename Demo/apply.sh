#!/bin/bash -x

set -e

fog apply -d demo_workspace --context /root --params org=root

fog apply -d demo_environments --context /root/demo 

fog apply -d url_redirect --context /root/demo/url_redirect --params api=demo-url-redirect --config ../config.yaml

fog apply -d vm_provision --context /root/demo/vm_provision --params api=demo-vm-provision --config ../config.yaml
