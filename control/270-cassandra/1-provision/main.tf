provider "rancher2" {
  api_url = var.rancher_api_url
  token_key = data.http.rancher-token.body
  insecure = true
}

data "http" "rancher-token" {
  url = var.rancher_token_lookup
}

data "rancher2_cluster" "home" {
  name = var.rancher_cluster_name
}

data "rancher2_project" "default" {
  name = "Default"
  cluster_id = data.rancher2_cluster.home.id
}

data "rancher2_catalog" "incubator" {
  name = "helm-incubator"
}

resource "rancher2_namespace" "cassandra" {
  name = "cassandra"
  project_id = data.rancher2_project.default.id
  wait_for_cluster = true
//  labels = {
//    "istio-injection": "enabled"
//  }
}

resource "rancher2_app" "cassandra" {
  name = "cassandra"
  target_namespace = rancher2_namespace.cassandra.name
  template_name = "cassandra"
  project_id = data.rancher2_project.default.id
  catalog_name = data.rancher2_catalog.incubator.name
  answers = {
  }
  timeouts {
    create = "20m"
    update = "20m"
  }
}
