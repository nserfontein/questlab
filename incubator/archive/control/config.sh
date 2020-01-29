#!/bin/bash
set -e

if [ ! -f "./config.sh" ]; then
   echo "This script must be run in the 'home-controller/control' directory"
   exit 1
fi

#ecg_username=$USER
#echo "ECG Username: $ecg_username"
#read -sp 'ECG Password: ' ecg_password
#
#echo ""
#echo ""
#echo "Go to https://github.corp.ebay.com/settings/developers and create a 'CSBA Sandbox' OAuth App"
#echo "  - Application Name: CSBA Sandbox"
#echo "  - Homepage URL:     http://rancher.dev-$ecg_username.ams1.cloud:81"
#echo "  - Callback URL:     http://rancher.dev-$ecg_username.ams1.cloud:81"
#echo ""
#read -p 'GitHub Client ID: ' github_client_id
#read -sp 'GitHub Client Secret: ' github_client_secret
#
#
#sed "s/{ECG_USERNAME}/$ecg_username/g; s/{ECG_PASSWORD}/$ecg_password/g;" ./config/ansible/hosts.template > ./config/ansible/hosts
#sed "s/{ECG_USERNAME}/$ecg_username/g; s/{ECG_PASSWORD}/$ecg_password/g; s/{GITHUB_CLIENT_ID}/$github_client_id/g; s/{GITHUB_CLIENT_SECRET}/$github_client_secret/g; " ./config/ansible/variables.yml.template > ./config/ansible/variables.yml
#sed "s/{ECG_USERNAME}/$ecg_username/g; s/{ECG_PASSWORD}/$ecg_password/g;" ./config/terraform/variables.tf.template > ./config/terraform/variables.tf
#

cat ./config/ansible/hosts.template > ./config/ansible/hosts
cat ./config/ansible/variables.yml.template > ./config/ansible/variables.yml
cat ./config/terraform/variables.tf.template > ./config/terraform/variables.tf

echo ""
echo ""
echo "Configuration saved successfully"
