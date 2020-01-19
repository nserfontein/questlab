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

resource "rancher2_catalog" "strimzi" {
  name = "strimzi"
  url = "https://strimzi.io/charts/"
}

resource "rancher2_namespace" "kafka" {
  name = "kafka"
  project_id = data.rancher2_project.default.id
  wait_for_cluster = true
  labels = {
    "istio-injection": "enabled"
  }
}

resource "rancher2_app" "strimzi" {
  name = "strimzi"
  target_namespace = rancher2_namespace.kafka.name
  template_name = "strimzi-kafka-operator"
  project_id = data.rancher2_project.default.id
  catalog_name = rancher2_catalog.strimzi.name
  answers = {
  }
  timeouts {
    create = "20m"
    update = "20m"
  }
}
