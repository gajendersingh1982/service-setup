module "batch_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = format("%s-%s-%s-%s-batch-sg", var.prefix, var.region_name, var.stage, var.service)
  description = "Security group for Jenkins"
  vpc_id      = data.terraform_remote_state.infra.outputs.vpc_id

  #Essential
  egress_rules             = ["all-all"]

  ingress_cidr_blocks      = [var.myip]
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

