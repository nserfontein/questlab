#!/bin/bash
set -e

if [ ! -f "./teardown.sh" ]; then
   echo "This script must be run in the 'questlab/control' directory"
   exit 1
fi

# TODO:
# https://rancher.com/docs/rancher/v2.x/en/cluster-admin/cleaning-cluster-nodes/

echo "Tearing down Controller..."
vagrant destroy -f

echo "Removing Terraform state..."
find . -type f -name 'terraform.tfstate*' -exec rm {} +

echo "Removing configurations..."
find . -type l -name 'variables.*' -exec rm {} +
find . -type l -name 'hosts' -exec rm {} +

echo "Done!"
