resource "helm_release" "argocd" {
  name = "argo-cd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "6.1.0"
  
  namespace        = "argocd"
  create_namespace = true

  timeout          = 600

  values = [file("${path.module}/../modules/argo-cd/values.yaml")]

  lifecycle {
    ignore_changes = [
      namespace
    ]
  }

  depends_on = [helm_release.nginx_ingress]
}


resource "helm_release" "argocd-apps" {
  depends_on = [helm_release.argocd]
  chart      = "argocd-apps"
  name       = "argocd-apps"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"


  values = [file("${path.module}/../modules/argocd-apps/values.yaml")]

  
}