data "terraform_remote_state" "cluster_list" {
  backend = "local"

  config = {
    path = "${path.module}/../kind/terraform.tfstate"
  }
}

data "template_file" "cluster_secret" {
  for_each = data.terraform_remote_state.cluster_list.outputs.cluster_info

  template = <<-EOF
apiVersion: v1
kind: Secret
metadata:
  name: argocd-cluster-secret-${each.value.name}
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: cluster
type: Opaque
stringData:
  name: "kind-${each.value.name}"
  server: "https://kubernetes.default.svc"
  config: |
    {
      "tlsClientConfig": {
        "insecure": false,
        "caData": "${base64encode(each.value.cluster_ca_certificate)}",
        "certData": "${base64encode(each.value.client_certificate)}",
        "keyData": "${base64encode(each.value.client_key)}"
      }
    }
EOF
}

resource "kubectl_manifest" "argocd-cluster-connect" {
  for_each = data.template_file.cluster_secret

  yaml_body = each.value.rendered
}
