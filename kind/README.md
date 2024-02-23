## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.1.5 |
| <a name="requirement_kind"></a> [kind](#requirement\_kind) | 0.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kind"></a> [kind](#provider\_kind) | 0.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kind_cluster.default](https://registry.terraform.io/providers/tehcyx/kind/0.2.1/docs/resources/cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_counts"></a> [cluster\_counts](#input\_cluster\_counts) | Número de clusters | `number` | `2` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | clusters names | `string` | `"k8s"` | no |
| <a name="input_kubernetes"></a> [kubernetes](#input\_kubernetes) | the kubernetes clusters | `string` | `"kind"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | the kubernetes versions of the clusters | `string` | `"1.27.3"` | no |
| <a name="input_worker_counts"></a> [worker\_counts](#input\_worker\_counts) | worker counts | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_info"></a> [cluster\_info](#output\_cluster\_info) | n/a |
