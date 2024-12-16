output "public_subnets" {
  value = module.vpc_main.public_subnet_ids
}

output "private_subnets" {
  value = module.vpc_main.private_subnet_ids
}

output "vpc_id" {
   value = module.vpc_main.vpc_id
}
