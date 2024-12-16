variable name {
  type = string
  description = "name"
}
variable engine_family {
  type = string
  description = "engine_family"
}
variable idle_client_timeout {
  type = string
  description = "idle_client_timeout"
}
variable require_tls {
  type = string
  description = "require_tls"
}
variable secret_arn {
  type = string
  description = "secret_arn"
}
variable tags {
  description = "Tag for the resources."
  type        = map(any)
  default = {
    Cloud     = "AWS"
    ManagedBy = "Terraform"
  }
}
variable db_cluster_identifier {
  type = string
  description = "db_cluster_identifier"
}
variable db_proxy_endpoint_name {
  type = string
  description = "db_proxy_endpoint_name"
}
variable vpc_subnet_ids {
  type = list(string)
  description = "subnet_ids"
}
variable vpc_security_group_ids {
  type = list(string)
  description = "vpc_security_group_ids"
}
variable connection_borrow_timeout {
  type = string
  description = "connection_borrow_timeout" 
  default = 120
}
variable max_connections_percent {
  type = string
  description = "max_connections_percent"  
  default = 100
}