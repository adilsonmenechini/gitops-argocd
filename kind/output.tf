output "cluster_info" {
  value = {
    for idx, instance in kind_cluster.default : instance.name => {
      container_ports = {
        for mapping in instance.kind_config[0].node[0].extra_port_mappings : mapping.container_port => mapping.host_port
      }
      api_server_address = instance.kind_config[0].networking[0].api_server_address
      api_server_port = instance.kind_config[0].networking[0].api_server_port
    } 
  }
}