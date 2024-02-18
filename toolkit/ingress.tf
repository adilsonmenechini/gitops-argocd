

resource "helm_release" "nginx_ingress" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.9.1"

  namespace        = "ingress-nginx"
  create_namespace = true

  wait         = true
  force_update = true

  values = [file("${path.module}/../modules/ingress-nginx/values.yaml")]

  depends_on = [helm_release.metrics_server]
}

# resource "null_resource" "wait_for_nginx_ingress" {
#   triggers = {
#     key = uuid()
#   }
#   provisioner "local-exec" {
#     command = <<EOF
#       printf "\nWaiting for the nginx ingress controller...\n"
#       kubectl wait --namespace ${helm_release.nginx_ingress.namespace} \
#         --for=condition=ready pod \
#         --selector=app.kubernetes.io/component=controller \
#         --timeout=180s
#     EOF
#   }

#   depends_on = [helm_release.nginx_ingress]
# }