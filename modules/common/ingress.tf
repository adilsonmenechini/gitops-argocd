resource "helm_release" "nginx_ingress" {
  name = "nginx-ingress-controller"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  namespace  = "kube-system"

  wait         = true
  force_update = true

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  depends_on = [helm_release.metrics_server]
}