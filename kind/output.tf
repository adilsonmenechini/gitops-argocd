output "cluster_info" {
  value = {
    for idx, instance in kind_cluster.default : instance.name => {
      container_ports = {
        for mapping in instance.kind_config[0].node[0].extra_port_mappings : mapping.container_port => mapping.host_port
      }
    }
  }
}