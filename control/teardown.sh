#!/bin/bash
set -e

if [ ! -f "./teardown.sh" ]; then
   echo "This script must be run in the 'home-cluster/control' directory"
   exit 1
fi

#echo "Tearing down Servers..."
#vagrant ssh -c "cd /vagrant/210-servers/1-provision; terraform destroy -auto-approve"
#
echo "Tearing down Controller..."
vagrant destroy -f

echo "Removing Terraform state..."
find . -type f -name 'terraform.tfstate*' -exec rm {} +

echo "Removing configurations..."
find . -type l -name 'variables.*' -exec rm {} +
find . -type l -name 'hosts' -exec rm {} +

echo "Done!"
