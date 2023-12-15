resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "5.34.6"
  timeout          = 600

  values = [file("${path.module}/values/argocd.yaml")]

  lifecycle {
    ignore_changes = [
      namespace
    ]
  }
}


resource "helm_release" "argo-rollouts" {
  name = "argo-rollouts"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-rollouts"
  namespace        = "argocd"
  create_namespace = true
  version          = "2.31.0"
  timeout          = 300

  lifecycle {
    ignore_changes = [
      namespace
    ]
  }

  depends_on = [
    helm_release.argocd
  ]
}


resource "helm_release" "argo-workflows" {
  name = "argo-workflows"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-workflows"
  namespace        = "argocd"
  create_namespace = true
  version          = "0.29.0"
  timeout          = 300

  lifecycle {
    ignore_changes = [
      namespace
    ]
  }

  depends_on = [
    helm_release.argocd
  ]
}

resource "kubernetes_config_map_v1_data" "argocd-cm" {
  depends_on = [helm_release.argocd]
  metadata {
    name      = "argocd-cm"
    namespace = "argocd"
  }

  force = true

  data = {
    config = file("${path.module}/values/argo-cm.yaml")
  }

}

data "kubectl_file_documents" "file" {
   
    content = file("${path.module}/../../gitops/bootstrap/argo-bootstrap.yaml")
}

resource "kubectl_manifest" "apl" {
     depends_on = [kubernetes_config_map_v1_data.argocd-cm]
    for_each  = data.kubectl_file_documents.file.manifests
    yaml_body = each.value
    
}

# resource "kubernetes_manifest" "app" {
#   manifest = yamldecode(file("${path.module}/../../../gitops/bootstrap/argo-bootstrap.yaml"))
# }