module "admin_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = format("%s-%s-%s-%s-admin-sg", var.prefix, var.region_name, var.stage, var.service)
  description = "Security group for Admin"
  #vpc_id      = module.vpc.vpc_id
  vpc_id      = data.terraform_remote_state.infra.outputs.vpc_id


  #Essential
  egress_rules             = ["all-all"]

  ingress_cidr_blocks      = var.restrictedIP
  ingress_rules            = ["https-443-tcp", "http-8080-tcp", "ssh-tcp"]
  /*
  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-8080-tcp"
      source_security_group_id = module.loadbalancer_admin_sg.this_security_group_id
    }
  ]

  number_of_computed_ingress_with_source_security_group_id = 1
  */
  tags                     = var.tags #Use common_vars.tf file for tags.Refer Note Below.
}

module "openapi_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = format("%s-%s-%s-%s-openapi-sg", var.prefix, var.region_name, var.stage, var.service)
  description = "Security group for openapi"
  #vpc_id      = module.vpc.vpc_id
  vpc_id      = data.terraform_remote_state.infra.outputs.vpc_id

  #Essential
  egress_rules             = ["all-all"]

  ingress_cidr_blocks      = var.restrictedIP
  ingress_rules            = ["http-8080-tcp", "ssh-tcp"]
  # ingress_with_self        = ["all-all"]

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-8080-tcp"
      source_security_group_id = module.loadbalancer_openapi_sg.this_security_group_id
    }
  ]

  number_of_computed_ingress_with_source_security_group_id = 1
  
  tags                     = var.tags #Use common_vars.tf file for tags.Refer Note Below.
}

module "loadbalancer_openapi_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = format("%s-%s-%s-%s-alb-sg", var.prefix, var.region_name, var.stage, var.service)
  description = "Security group for prometheus"
  #vpc_id      = module.vpc.vpc_id
  vpc_id      = data.terraform_remote_state.infra.outputs.vpc_id

  ingress_cidr_blocks = [var.publicIP]
  ingress_rules       = ["https-443-tcp","http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]

  tags        = var.tags #Use common_vars.tf file for tags.Refer Note Below.
}

module "loadbalancer_admin_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = format("%s-%s-%s-%s-alb-admin-sg", var.prefix, var.region_name, var.stage, var.service)
  description = "Security group for prometheus"
  #vpc_id      = module.vpc.vpc_id
  vpc_id      = data.terraform_remote_state.infra.outputs.vpc_id

  ingress_cidr_blocks = var.restrictedIP
  ingress_rules       = ["https-443-tcp", "http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]

  tags        = var.tags #Use common_vars.tf file for tags.Refer Note Below.
}

