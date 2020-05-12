locals {
  was_ami = data.aws_ami.was_ami.id
}

data "template_file" "admin_env" {
  template = file("./enviornment.sh")
  vars = {
    aws_access_key_id = var.access
    secret_access_key_id = var.secret
  }
}

data "template_cloudinit_config" "admin_config" {
  gzip          = true
  base64_encode = true

  # get user_data --> Prometheus
  part {
    filename     = "admin.cfg"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.admin_env.rendered}"
  }
}

module "admin" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.13.0"
  
  #essential [required for Infra Governance]
  name                    = format("%s-%s-%s-%s-admin", var.prefix, var.region_name, var.stage, var.service)
  instance_count          = "1"

  ami                     = local.was_ami
  instance_type           = var.instance_type_admin
  key_name                = var.key_name
  monitoring              = false

  vpc_security_group_ids  = [module.admin_sg.this_security_group_id]
  subnet_ids              = data.terraform_remote_state.infra.outputs.private_subnets

  # set instance profile to give EC2 read only permissions
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile_admin.name

  # set user data for configuring server  
  user_data               = data.template_cloudinit_config.admin_config.rendered

  tags                    = var.tags
}


 resource "aws_lb_target_group_attachment" "admin-tg-attachment-01" {
  target_group_arn = module.lb_admin.target_group_arns[0]
  target_id        = module.admin.id
  port             = 80
}
