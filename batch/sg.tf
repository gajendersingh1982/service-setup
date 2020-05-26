module "batch_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = format("%s-%s-%s-%s-batch-sg", var.prefix, var.region_name, var.stage, var.service)
  description = "Security group for Jenkins"
  vpc_id      = data.terraform_remote_state.infra.outputs.vpc_id

  #Essential
  egress_rules             = ["all-all"]

  ingress_cidr_blocks      = var.restrictedIP 
  ingress_rules            = ["https-443-tcp", "http-8080-tcp", "ssh-tcp"]
  
  # computed_ingress_with_source_security_group_id = [
  #   {
  #     rule                     = "http-8080-tcp"
  #     source_security_group_id = module.loadbalancer_admin_sg.this_security_group_id
  #   }
  # ]
  # number_of_computed_ingress_with_source_security_group_id = 1

  tags                     = var.tags
}

module "mail_train_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = format("%s-%s-%s-%s-mail-train-sg", var.prefix, var.region_name, var.stage, var.service)
  description = "Security group for Mail Train"
  vpc_id      = data.terraform_remote_state.infra.outputs.vpc_id

  #Essential
  egress_rules             = ["all-all"]

  ingress_cidr_blocks      = var.restrictedIP 
  ingress_rules            = ["https-443-tcp", "http-80-tcp", "http-8080-tcp", "ssh-tcp"]
  
ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "Ingress form all OpenAPI / Batch / Admin servers"
      cidr_blocks = "10.0.0.0/8"
    },
    {
      rule        = "http-80-tcp"
      cidr_blocks = "10.0.0.0/8"
    },
  ]

  tags                     = var.tags
}

