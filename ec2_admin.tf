data "template_file" "setup-admin" {
  template = file("./scripts/tomcat.sh")
  vars = {
    # Any variables to be passed in shell script
  }
}

data "template_cloudinit_config" "admin" {
  gzip          = true
  base64_encode = true

  # get user_data --> Prometheus
  part {
    filename     = "jenkins-admin.cfg"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.setup-admin.rendered}"
  }
}

module "admin" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.13.0"
  
  #essential [required for Infra Governance]
  name                    = format("%s-%s-%s-%s-admin", var.prefix, var.region_name, var.stage, var.service)
  instance_count          = var.admin_count

  ami                     = data.aws_ami.ubuntu18.id
  instance_type           = var.instance_type_admin
  key_name                = var.key_name
  monitoring              = false

  vpc_security_group_ids  = [module.batch_sg.this_security_group_id]
  subnet_ids              = module.vpc.public_subnets

  # set instance profile to give EC2 read only permissions
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile_api.name

  # set user data for configuring server  
  user_data               = data.template_cloudinit_config.admin.rendered

  tags                    = var.tags
}

#EIP for Batch server
resource "aws_eip" "eip_admin" {
  count = var.admin_count
  vpc = true
}

resource "aws_eip_association" "eip_assoc_admin" {
  count         = var.admin_count
  instance_id   = element(module.admin.id[*], count.index)
  allocation_id = element(aws_eip.eip_admin.*.id, count.index)
}