resource "kind_cluster" "default" {
  count          = var.cluster_counts
  name           = "${var.cluster_name}0${count.index}"
  wait_for_ready = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

  networking {
    api_server_address = "127.0.0.1"
    api_server_port = 64431 + count.index
  }
    node {
      role  = "control-plane"
      image = "kindest/node:v${var.kubernetes_version}"

      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]

      extra_port_mappings {
        container_port = 80
        host_port      = 38081 + count.index
      }
      extra_port_mappings {
        container_port = 443
        host_port      = 44431 + count.index
      }
    }

    dynamic "node" {
      for_each = { for idx in range(var.worker_counts) : idx => idx }
      content {
        role  = "worker"
        image = "kindest/node:v${var.kubernetes_version}"
      }
    }

  }
}
