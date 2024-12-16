variable subnet_ids {
  type = list(string)
  description = "subnet_ids"
}
variable parameter_group_family {
  type = string
  description = "parameter_group_family"
}
variable cluster_identifier {
  type = string
  description = "cluster_identifier"
}
variable engine {
  type = string
  description = "engine"
}
variable engine_mode {
  type = string
  description = "engine_mode"
}
variable engine_version {
  type = string
  description = "engine_version"
}
variable database_name {
  type = string
  description = "database_name"
}
variable storage_encrypted {
  type = string
  description = "storage_encrypted"
  default = true
}
variable skip_final_snapshot {
  type = string
  description = "skip_final_snapshot"
  default = true
}
variable enable_http_endpoint {
  type = string
  description = "enable_http_endpoint"
  default = true
}
variable vpc_security_group_ids {
  type = list(string)
  description = "vpc_security_group_ids"
}
variable tags {
  description = "tags"
  type        = map(any)
  default = {
    ManagedBy = "Terraform"
  }
}
variable master_username {
  description = "master_username"
  type = string
  default = "root"
}
variable master_password {
  description = "master_password"
  type = string
}
variable max_capacity {
  description = "description"
  type = string
  default = 1.0
}
variable min_capacity {
  description = "description"
  type = string
  default = 0.5
}
variable instance_class {
  description = "description"
  type = string
  default = "db.serverless"
}
variable instaces_count {
  description = "numeric value of the number of instances"
  default = 1
}
variable "parameters" {
  description = "parameters"
  type = list(object({
     apply_method = string
     name         = string
     value        = string
  }))
  default = []
}

variable final_snapshot_identifier {
  type = string
  default = "final-snapshot"
  description = "final_snapshot_identifier"
}
variable apply_immediately {
  type = bool
  default = false
  description = "apply_immediately"
}
variable allow_major_version_upgrade {
  type = bool
  default = false
  description = "allow_major_version_upgrade"
}
variable deletion_protection {
  type = bool
  default = true
  description = "deletion_protection"
}
variable backup_retention_period {
  type = string
  default = 7
  description = "backup_retention_period"
}
variable preferred_backup_window {
  type = string
  default = "02:00-03:00"
  description = "preferred_backup_window"
}
variable preferred_maintenance_window {
  type = string
  default = "sun:07:27-sun:07:57"
  description = "preferred_maintenance_window"
}
variable enabled_cloudwatch_logs_exports {
  type = list(string)
  default = ["postgresql"]
  description = "enabled_cloudwatch_logs_exports"
}