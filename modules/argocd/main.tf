resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.51.6"
  
  namespace        = "argocd"
  create_namespace = true

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
  version          = "2.33.0"
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
  version          = "0.40.1"
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
    config = file("${path.module}/values/argocd-cm.yaml")
  }

}


resource "helm_release" "argocd-apps" {
  depends_on = [kubernetes_config_map_v1_data.argocd-cm]
  chart      = "argocd-apps"
  name       = "argocd-apps"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"


  values = [file("${path.module}/values/application.yaml")]
}