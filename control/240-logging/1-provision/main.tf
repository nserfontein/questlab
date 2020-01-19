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

data "rancher2_catalog" "library" {
  name = "library"
}

resource "rancher2_namespace" "efk" {
  name = "efk"
  project_id = data.rancher2_project.default.id
  wait_for_cluster = true
}

resource "rancher2_app" "efk" {
  name = "efk"
  target_namespace = rancher2_namespace.efk.name
  template_name = "efk"
  project_id = data.rancher2_project.default.id
  catalog_name = data.rancher2_catalog.library.name
  answers = {
//    "defaultImage": "true"
//    "elasticsearch.image": "ranchercharts/elasticsearch-elasticsearch"
//    "elasticsearch.imageTag": "7.3.0"
//    "kibana.image": "ranchercharts/kibana-kibana"
//    "kibana.imageTag": "7.3.0"
//    "filebeat.image": "ranchercharts/beats-filebeat"
//    "filebeat.imageTag": "7.3.0"
//    "metricbeat.image": "ranchercharts/beats-metricbeat"
//    "metricbeat.imageTag": "7.3.0"
//    "metricbeat.kube-state-metrics.image.repository": "ranchercharts/coreos-kube-state-metrics"
//    "metricbeat.kube-state-metrics.image.tag": "v1.7.2"
//    "kibana.language": "en"
    "kibana.service.type": "NodePort"
//    "kibana.enableProxy": "true"
    "elasticsearch.replicas": "1"
//    "elasticsearch.antiAffinity": "hard"
    "elasticsearch.persistence.enabled": "true"
    "elasticsearch.persistence.storageClass": "longhorn"
    "elasticsearch.persistence.size": "10Gi"
//    "filebeat.enabled": "true"
//    "metricbeat.enabled": "true"
  }
  timeouts {
    create = "20m"
    update = "20m"
  }
}
