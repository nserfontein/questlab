#!/bin/bash
set -e

if [ ! -f "./setup.sh" ]; then
   echo "This script must be run in the 'home-controller/control' directory"
   exit 1
fi

target=${1:-all}

if [ "$target" == "controller" ] || [ "$target" == "all" ]; then
  echo ""
  echo "=========================================="
  echo "CONFIGURING: CONTROLLER"
  echo "=========================================="
  echo ""
  vagrant up --provision
  vagrant ssh -c "cd /vagrant/110-controller; sh main.sh"
fi

if [ "$target" == "servers" ] || [ "$target" == "all" ]; then
  echo ""
  echo "=========================================="
  echo "CONFIGURING: SERVERS"
  echo "=========================================="
  echo ""
  ln -sf ../../config/ansible/hosts ./210-servers/1-configure/
  ln -sf ../../config/ansible/variables.yml ./210-servers/1-configure/
  vagrant ssh -c "cd /vagrant/210-servers/1-configure; ansible-playbook main.yml"
fi

if [ "$target" == "cluster" ] || [ "$target" == "all" ]; then
  echo ""
  echo "=========================================="
  echo "PROVISIONING: CLUSTER"
  echo "=========================================="
  echo ""
  ln -sf ../../config/terraform/variables.tf ./220-cluster/1-provision/
  vagrant ssh -c "cd /vagrant/220-cluster/1-provision; terraform init; terraform apply -auto-approve"
  echo ""
  echo "=========================================="
  echo "CONFIGURING: CLUSTER"
  echo "=========================================="
  echo ""
  ln -sf ../../config/ansible/hosts ./220-cluster/2-configure/
  ln -sf ../../config/ansible/variables.yml ./220-cluster/2-configure/
  vagrant ssh -c "cd /vagrant/220-cluster/2-configure; ansible-playbook main.yml"
fi
#
#if [ "$target" == "storage" ] || [ "$target" == "all" ]; then
#  echo ""
#  echo "=========================================="
#  echo "PROVISIONING: STORAGE"
#  echo "=========================================="
#  echo ""
#  ln -sf ../../config/terraform/variables.tf ./230-storage/1-provision/
#  vagrant ssh -c "cd /vagrant/230-storage/1-provision; terraform init; terraform apply -auto-approve"
#fi
#
#if [ "$target" == "logging" ] || [ "$target" == "all" ]; then
#  echo ""
#  echo "=========================================="
#  echo "PROVISIONING: LOGGING"
#  echo "=========================================="
#  echo ""
#  ln -sf ../../config/terraform/variables.tf ./240-logging/1-provision/
#  vagrant ssh -c "cd /vagrant/240-logging/1-provision; terraform init; terraform apply -auto-approve"
#fi
#
#if [ "$target" == "monitoring" ] || [ "$target" == "all" ]; then
#  echo ""
#  echo "=========================================="
#  echo "CONFIGURING: MONITORING"
#  echo "=========================================="
#  echo ""
#  ln -sf ../../config/ansible/hosts ./250-monitoring/1-configure/
#  ln -sf ../../config/ansible/variables.yml ./250-monitoring/1-configure/
#  vagrant ssh -c "cd /vagrant/250-monitoring/1-configure; ansible-playbook main.yml"
#  echo ""
#  echo "=========================================="
#  echo "PROVISIONING: MONITORING"
#  echo "=========================================="
#  echo ""
#  ln -sf ../../config/terraform/variables.tf ./250-monitoring/2-provision/
#  vagrant ssh -c "cd /vagrant/250-monitoring/2-provision; terraform init; terraform apply -auto-approve"
#fi
#
#if [ "$target" == "kafka" ] || [ "$target" == "all" ]; then
#  echo ""
#  echo "=========================================="
#  echo "PROVISIONING: KAFKA"
#  echo "=========================================="
#  echo ""
#  ln -sf ../../config/terraform/variables.tf ./260-kafka/1-provision/
#  vagrant ssh -c "cd /vagrant/260-kafka/1-provision; terraform init; terraform apply -auto-approve"
#  echo ""
#  echo "=========================================="
#  echo "CONFIGURING: KAFKA"
#  echo "=========================================="
#  echo ""
#  ln -sf ../../config/ansible/hosts ./260-kafka/2-configure/
#  ln -sf ../../config/ansible/variables.yml ./260-kafka/2-configure/
#  vagrant ssh -c "cd /vagrant/260-kafka/2-configure; ansible-playbook main.yml"
#fi
#
#if [ "$target" == "mariadb" ] || [ "$target" == "all" ]; then
#  echo ""
#  echo "=========================================="
#  echo "PROVISIONING: MARIADB"
#  echo "=========================================="
#  echo ""
#  ln -sf ../../config/terraform/variables.tf ./270-mariadb/1-provision/
#  vagrant ssh -c "cd /vagrant/270-mariadb/1-provision; terraform init; terraform apply -auto-approve"
#  echo ""
#  echo "=========================================="
#  echo "CONFIGURING: MARIADB"
#  echo "=========================================="
#  echo ""
#  ln -sf ../../config/ansible/hosts ./270-mariadb/2-configure/
#  ln -sf ../../config/ansible/variables.yml ./270-mariadb/2-configure/
#  vagrant ssh -c "cd /vagrant/270-mariadb/2-configure; ansible-playbook main.yml"
#fi
#
#if [ "$target" == "wiremock" ] || [ "$target" == "all" ]; then
#  echo ""
#  echo "=========================================="
#  echo "PROVISIONING: WIREMOCK"
#  echo "=========================================="
#  echo ""
#  ln -sf ../../config/ansible/hosts ./300-wiremock/1-configure/
#  ln -sf ../../config/ansible/variables.yml ./300-wiremock/1-configure/
#  vagrant ssh -c "cd /vagrant/300-wiremock/1-configure; ansible-playbook main.yml"
#fi
#
#if [ "$target" == "registry" ] || [ "$target" == "all" ]; then
#  echo ""
#  echo "=========================================="
#  echo "CONFIGURING: REGISTRY"
#  echo "=========================================="
#  echo ""
#  ln -sf ../../config/ansible/hosts ./310-registry/1-configure/
#  ln -sf ../../config/ansible/variables.yml ./310-registry/1-configure/
#  vagrant ssh -c "cd /vagrant/310-registry/1-configure; ansible-playbook main.yml"
#fi
#
#if [ "$target" == "ingress" ] || [ "$target" == "all" ]; then
#  echo ""
#  echo "=========================================="
#  echo "CONFIGURING: INGRESS"
#  echo "=========================================="
#  echo ""
#  ln -sf ../../config/ansible/hosts ./410-ingress/1-configure/
#  ln -sf ../../config/ansible/variables.yml ./410-ingress/1-configure/
#  vagrant ssh -c "cd /vagrant/410-ingress/1-configure; ansible-playbook main.yml"
#fi

