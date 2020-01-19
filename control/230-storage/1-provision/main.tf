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

resource "rancher2_namespace" "longhorn-system" {
  name = "longhorn-system"
  project_id = data.rancher2_project.default.id
  wait_for_cluster = true
}

resource "rancher2_app" "longhorn" {
  name = "longhorn"
  target_namespace = rancher2_namespace.longhorn-system.name
  template_name = "longhorn"
  project_id = data.rancher2_project.default.id
  catalog_name = data.rancher2_catalog.library.name
  answers = {
    "csi.attacherImage": null
    "csi.provisionerImage": null
    "csi.driverRegistrarImage": null
    "csi.kubeletRootDir": null
    "csi.attacherReplicaCount": null
    "csi.provisionerReplicaCount": null
    "persistence.defaultClass": true
    "persistence.defaultClassReplicaCount": "1"
    "defaultSettings.backupTarget": null
    "defaultSettings.backupTargetCredentialSecret": null
    "defaultSettings.createDefaultDiskLabeledNodes": false
    "defaultSettings.defaultDataPath": "/var/lib/rancher/longhorn/"
    "defaultSettings.replicaSoftAntiAffinity": true
    "defaultSettings.storageOverProvisioningPercentage": "500"
    "defaultSettings.storageMinimalAvailablePercentage": "10"
    "defaultSettings.upgradeChecker": true
    "defaultSettings.defaultReplicaCount": "1"
    "defaultSettings.guaranteedEngineCPU": "0"
    "defaultSettings.defaultLonghornStaticStorageClass": "longhorn-static"
    "defaultSettings.backupstorePollInterval": "300"
    "defaultSettings.taintToleration": null
    "ingress.enabled": false
    "ingress.host": "xip.io"
    "service.ui.type": "Rancher-Proxy"
    "service.ui.nodePort": null
  }
  timeouts {
    create = "20m"
    update = "20m"
  }
}
