locals {
  asg_ami = data.aws_ami.was_ami.id
}

data "template_file" "openapi_env" {
  template = file("./enviornment.sh")
  vars = {
    aws_access_key_id = var.aws_access_key_id
    secret_access_key_id = var.secret_access_key_id
  }
}

data "template_cloudinit_config" "openapi_config" {
  gzip          = true
  base64_encode = true

  # get user_data --> Prometheus
  part {
    filename     = "admin.cfg"
    content_type = "text/x-shellscript"
    content      = "${data.template_file.openapi_env.rendered}"
  }
}

resource "aws_launch_configuration" "api_conf" {
  name          = format("%s-%s-%s-%s-web-config", var.prefix, var.region_name, var.stage, var.service)
  #image_id      = data.aws_ami.ubuntu18.id
  image_id      = local.asg_ami
  instance_type = var.instance_type_openapi
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile_api.name

  security_groups = [module.openapi_sg.this_security_group_id]

  # set user data for configuring server  
  user_data               = data.template_cloudinit_config.openapi_config.rendered

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "api_asg" {
  name                    = format("%s-%s-%s-%s-asg", var.prefix, var.region_name, var.stage, var.service)
  launch_configuration    = aws_launch_configuration.api_conf.name
  desired_capacity        = 1
  min_size                = 1
  max_size                = 2
  vpc_zone_identifier     = data.terraform_remote_state.infra.outputs.private_subnets  #module.vpc.private_subnets

  #target_group_arns = module.lb_openapi.target_group_arns

  lifecycle {
    create_before_destroy = true
  }
  # tags = var.tags
  tag {
    key                 = "Service"
    value               = var.service
    propagate_at_launch = true
  }
  tag {
    key                 = "stage"
    value               = var.stage
    propagate_at_launch = true
  }
  tag {
    key                 = "Name"
    value               = format("%s-%s-%s-%s-openapi", var.prefix, var.region_name, var.stage, var.service)
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "scalepolicy" {
  name                   = format("%s-%s-%s-%s-scalepolicy", var.prefix, var.region_name, var.stage, var.service)
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.api_asg.name
}
