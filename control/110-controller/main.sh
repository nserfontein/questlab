#!/bin/bash

ANSIBLE_VERSION=2.8.5
TERRAFORM_VERSION=0.12.8

sudo apt-get update

sudo apt-get install -y unzip python-pip

sudo -H pip install ansible==$ANSIBLE_VERSION jmespath

sudo curl -s -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo unzip /tmp/terraform.zip -d /tmp/terraform
sudo mv /tmp/terraform/terraform /usr/bin/terraform
sudo chmod +x /usr/bin/terraform
