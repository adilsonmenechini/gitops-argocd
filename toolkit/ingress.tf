

resource "helm_release" "nginx_ingress" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.9.1"

  namespace        = "ingress-nginx"
  create_namespace = true

  wait         = true
  force_update = true

  timeout          = 600

  values = [file("${path.module}/../modules/ingress-nginx/values.yaml")]

  depends_on = [helm_release.metrics_server]
}