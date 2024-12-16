module "ec2-instance" {    
  source = "../../modules/ec2"

  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = var.iam_instance_profile
  ubuntu_codename             = var.ubuntu_codename
  ami_specific_id             = var.ami_specific_id
  ubuntu_version              = var.ubuntu_version
  instance_type               = var.instance_type
  name_instance               = var.name_instance
  public_key                  = var.public_key
  subnet_id                   = module.vpc_main.public_subnet_ids[0]
  ami_type                    = var.ami_type
  vpc_security_group_ids      = [module.security_groupSG.id]
}