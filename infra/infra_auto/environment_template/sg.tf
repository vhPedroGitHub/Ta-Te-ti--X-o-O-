module "security_groupSG" {
  source = "../../modules/security_group"

  grup_sg_name = var.grup_sg_name
  grup_sg_description = var.grup_sg_description
  ingress_rules = var.ingress_rules
  egress_rules = var.egress_rules
  vpc_id = module.vpc_main.vpc_id
}