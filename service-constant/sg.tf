module "db_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = format("%s-%s-%s-%s-db-sg", var.prefix, var.region_name, var.stage, var.service)
  description = "Security group for prometheus"
  #vpc_id      = module.vpc.vpc_id
  vpc_id      = data.terraform_remote_state.infra.outputs.vpc_id

  ingress_cidr_blocks = var.restrictedIP
  ingress_rules       = ["mysql-tcp"]
  egress_rules        = ["all-all"]

  tags        = var.tags #Use common_vars.tf file for tags.Refer Note Below.
}


module "loadbalancer_openapi_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = format("%s-%s-%s-%s-alb-openapi-sg", var.prefix, var.region_name, var.stage, var.service)
  description = "Security group for open API LoadBalancer"
  vpc_id      = data.terraform_remote_state.infra.outputs.vpc_id

  ingress_cidr_blocks = [var.publicIP]
  ingress_rules       = ["https-443-tcp"]
  egress_rules        = ["all-all"]

  tags        = var.tags #Use common_vars.tf file for tags.Refer Note Below.
}

module "loadbalancer_admin_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = format("%s-%s-%s-%s-alb-admin-sg", var.prefix, var.region_name, var.stage, var.service)
  description = "Security group for admin load balancer"
  vpc_id      = data.terraform_remote_state.infra.outputs.vpc_id

  ingress_cidr_blocks = var.restrictedIP
  ingress_rules       = ["https-443-tcp"]
  egress_rules        = ["all-all"]

  tags        = var.tags #Use common_vars.tf file for tags.Refer Note Below.
}