module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.33.0"

  cidr                  = var.vpc_cidr
  #essential [required for Infra Governance]
  name                   = format("%s-%s-%s-%s", var.prefix, var.region_name, var.stage, var.service)
  azs                    = var.azs
  public_subnets         = var.public_subnets
  private_subnets        = var.private_subnets
  enable_nat_gateway     = "true"
  single_nat_gateway     = "false"
  enable_dns_hostnames   = "true"
  one_nat_gateway_per_az = "true"
  tags                   = var.tags
}