
output "cluster_info" {
  value = {
    for idx, instance in kind_cluster.default : instance.name => {

      # api_server_address = instance.kind_config[0].networking[0].api_server_address
      # api_server_port = instance.kind_config[0].networking[0].api_server_port
      name = instance.name
      host = instance.endpoint
      client_certificate = instance.client_certificate
      client_key = instance.client_key
      cluster_ca_certificate = instance.cluster_ca_certificate
      container_ports = {
        for mapping in instance.kind_config[0].node[0].extra_port_mappings : mapping.container_port => mapping.host_port
      }
    } 
  }
}