data "aws_availability_zones" "available" {}

# data "aws_rds_engine_version" "family" {
#   engine   = var.engine
#   version  = var.engine_version
# }

resource "aws_rds_cluster" "cluster_rds" {
  cluster_identifier     = var.cluster_identifier
  engine                 = var.engine
  engine_mode            = var.engine_mode
  engine_version         = var.engine_version
  database_name          = var.database_name
  storage_encrypted      = var.storage_encrypted
  enable_http_endpoint   = var.enable_http_endpoint
  master_username        = var.master_username
  master_password        = var.master_password
  #manage_master_user_password = true
  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name   = aws_db_subnet_group.subnet_group_rds.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.pgroup_rds.name

  serverlessv2_scaling_configuration {
    max_capacity = var.max_capacity
    min_capacity = var.min_capacity
  }

  skip_final_snapshot             = var.skip_final_snapshot
  final_snapshot_identifier       = var.final_snapshot_identifier
  apply_immediately               = var.apply_immediately
  allow_major_version_upgrade     = var.allow_major_version_upgrade
  deletion_protection             = var.deletion_protection
  backup_retention_period         = var.backup_retention_period
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  availability_zones              = slice(data.aws_availability_zones.available.names, 0, 3)
}

resource "aws_rds_cluster_instance" "rds_aurora_instances" {
  count              = var.instaces_count
  cluster_identifier = aws_rds_cluster.cluster_rds.id
  identifier         = "instance-${count.index + 1}"
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.cluster_rds.engine
  engine_version     = aws_rds_cluster.cluster_rds.engine_version
}


resource "aws_db_subnet_group" "subnet_group_rds" {
  name        = "${var.cluster_identifier}-subnet-group"
  subnet_ids  = var.subnet_ids
  tags = var.tags
}

resource "aws_rds_cluster_parameter_group" "pgroup_rds" {
  name   = "${var.cluster_identifier}-cluster-parameter-group"
  family = var.parameter_group_family

  dynamic "parameter" {
    for_each = length(var.parameters) > 0 ? var.parameters : []
    content {
      apply_method = parameter.value.apply_method
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }
}