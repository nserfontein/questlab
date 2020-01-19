output "rancher_node_command" {
  value = rancher2_cluster.csba-sandbox.cluster_registration_token[0].node_command
}

# TODO: Put this value in Consul directly
resource "local_file" "add-node-command" {
  filename = "/home/vagrant/add-node-command.txt"
  content = rancher2_cluster.csba-sandbox.cluster_registration_token[0].node_command
}
