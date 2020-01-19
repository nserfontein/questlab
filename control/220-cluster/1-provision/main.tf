data "http" "rancher-token" {
  url = var.rancher_token_lookup
}

provider "rancher2" {
  api_url = var.rancher_api_url
  token_key = data.http.rancher-token.body
  insecure = true
}

resource "rancher2_setting" "server-url" {
  name = "server-url"
  value = var.rancher_server_url
}

resource "rancher2_cluster" "csba-sandbox" {
  name = var.rancher_cluster_name
  rke_config {
    network {
      plugin = var.rancher_network_plugin
    }
  }
}
