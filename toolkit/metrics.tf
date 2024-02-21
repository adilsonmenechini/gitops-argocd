resource "helm_release" "metrics_server" {
  name = "metrics-server"

  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
  version    = "3.12.0"

  values = [file("${path.module}/../modules/metrics-server/values.yaml")]

  wait = true
  force_update = true

  timeout          = 600

}