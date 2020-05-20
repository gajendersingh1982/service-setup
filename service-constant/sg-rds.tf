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
