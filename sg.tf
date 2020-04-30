module "batch_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = format("%s-%s-%s-%s-batch-sg", var.prefix, var.region_name, var.stage, var.service)
  description = "Security group for Jenkins"
  vpc_id      = module.vpc.vpc_id

  #Essential
  egress_rules             = ["all-all"]

  ingress_cidr_blocks      = [var.myip]
  ingress_rules            = ["https-443-tcp", "http-8080-tcp", "ssh-tcp"]
  # ingress_with_self        = ["all-all"]
  
  tags                     = var.tags #Use common_vars.tf file for tags.Refer Note Below.
}

module "openapi_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = format("%s-%s-%s-%s-openapi-sg", var.prefix, var.region_name, var.stage, var.service)
  description = "Security group for prometheus"
  vpc_id      = module.vpc.vpc_id

  #Essential
  egress_rules             = ["all-all"]

  ingress_cidr_blocks      = [var.myip]
  ingress_rules            = ["http-8080-tcp", "ssh-tcp"]
  # ingress_with_self        = ["all-all"]
  
  tags                     = var.tags #Use common_vars.tf file for tags.Refer Note Below.
}

module "loadbalancer_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = format("%s-%s-%s-%s-alb-sg", var.prefix, var.region_name, var.stage, var.service)
  description = "Security group for prometheus"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [var.publicIP]
  ingress_rules       = ["https-443-tcp","http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]

  tags        = var.tags #Use common_vars.tf file for tags.Refer Note Below.
}

module "loadbalancer_admin_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = format("%s-%s-%s-%s-alb-admin-sg", var.prefix, var.region_name, var.stage, var.service)
  description = "Security group for prometheus"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [var.myip]
  ingress_rules       = ["https-443-tcp", "http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]

  tags        = var.tags #Use common_vars.tf file for tags.Refer Note Below.
}