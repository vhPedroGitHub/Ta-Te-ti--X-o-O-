module "rds-database-dev" {
  source = "../../modules/rds_instance"

  instance_class = var.instance_class
  engine_version = var.engine_version
  security_group = module.security_groupSG.id
  username       = var.username
  password       = var.password
  dbname         = var.dbname
  engine         = var.engine
  name           = var.name
  subnet_ids     = module.vpc_main.private_subnet_ids
}