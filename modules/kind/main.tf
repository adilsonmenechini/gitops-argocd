resource "kind_cluster" "default" {
  name           = var.cluster_name
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role  = "control-plane"
      image = "kindest/node:v${var.kubernetes_version}"

      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]

      extra_port_mappings {
        container_port = 80
        host_port      = 80
      }
      extra_port_mappings {
        container_port = 443
        host_port      = 443
      }
    }

    node {
      role  = "worker"
      image = "kindest/node:v${var.kubernetes_version}"
    }

    node {
      role  = "worker"
      image = "kindest/node:v${var.kubernetes_version}"
    }

    node {
      role  = "worker"
      image = "kindest/node:v${var.kubernetes_version}"
    }
  }
}
