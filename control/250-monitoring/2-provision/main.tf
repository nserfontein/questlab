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

data "rancher2_project" "system" {
  name = "System"
  cluster_id = data.rancher2_cluster.home.id
}

data "rancher2_catalog" "system-library" {
  name = "system-library"
}

resource "rancher2_namespace" "istio-system" {
  name = "istio-system"
  project_id = data.rancher2_project.system.id
  wait_for_cluster = true
}

resource "rancher2_app" "cluster-istio" {
  name = "cluster-istio"
  target_namespace = rancher2_namespace.istio-system.name
  template_name = "rancher-istio"
  project_id = data.rancher2_project.system.id
  catalog_name = data.rancher2_catalog.system-library.name
  answers = {
//    "certmanager.enabled":"false",
//    "enableCRDs":"true",
//    "galley.enabled":"true",
//    "gateways.enabled":"false",
//    "gateways.istio-ingressgateway.resources.limits.cpu":"2000m",
//    "gateways.istio-ingressgateway.resources.limits.memory":"1024Mi",
//    "gateways.istio-ingressgateway.resources.requests.cpu":"100m",
//    "gateways.istio-ingressgateway.resources.requests.memory":"128Mi",
//    "gateways.istio-ingressgateway.type":"NodePort",
//    "global.members[0].kind":"Group",
//    "global.members[0].name":"system:authenticated",
//    "global.monitoring.type":"cluster-monitoring",
//    "global.rancher.clusterId":"c-4lknj",
//    "global.rancher.domain":"rancher.dev-nserfontein.ams1.cloud",
//    "istio_cni.enabled":"false",
//    "istiocoredns.enabled":"false",
//    "kiali.enabled":"true",
//    "mixer.enabled":"true",
//    "mixer.policy.enabled":"true",
//    "mixer.policy.resources.limits.cpu":"4800m",
//    "mixer.policy.resources.limits.memory":"4096Mi",
//    "mixer.policy.resources.requests.cpu":"1000m",
//    "mixer.policy.resources.requests.memory":"1024Mi",
//    "mixer.telemetry.resources.limits.cpu":"4800m",
//    "mixer.telemetry.resources.limits.memory":"4096Mi",
//    "mixer.telemetry.resources.requests.cpu":"1000m",
//    "mixer.telemetry.resources.requests.memory":"1024Mi",
//    "mtls.enabled":"false",
//    "nodeagent.enabled":"false",
//    "pilot.enabled":"true",
//    "pilot.resources.limits.cpu":"1000m",
//    "pilot.resources.limits.memory":"4096Mi",
//    "pilot.resources.requests.cpu":"500m",
//    "pilot.resources.requests.memory":"2048Mi",
//    "pilot.traceSampling":"1",
//    "security.enabled":"true",
//    "sidecarInjectorWebhook.enabled":"true",
//    "tracing.enabled":"true",
//    "tracing.jaeger.resources.limits.cpu":"500m",
//    "tracing.jaeger.resources.limits.memory":"1024Mi",
//    "tracing.jaeger.resources.requests.cpu":"100m",
//    "tracing.jaeger.resources.requests.memory":"100Mi"
  }
  timeouts {
    create = "20m"
    update = "20m"
  }
}

//resource "rancher2_namespace" "default" {
//  name = "default"
//  project_id = data.rancher2_project.system.id
//  wait_for_cluster = true
//  labels = {
//    "istio-injection": "enabled"
//  }
//}
