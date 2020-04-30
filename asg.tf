data "template_file" "setup-tomcat" {
  template = file("./scripts/tomcat.sh")
  vars = {
    # Any variables to be passed in shell script
  }
}

data "template_cloudinit_config" "openapi" {
  gzip          = true
  base64_encode = true

  # get user_data --> Prometheus
  part {
    filename     = "tomcat.cfg"
    content_type = "text/x-shellscript"
    content      = data.template_file.setup-tomcat.rendered
  }
}

resource "aws_launch_configuration" "api_conf" {
  name          = format("%s-%s-%s-%s-web-config", var.prefix, var.region_name, var.stage, var.service)
  image_id      = data.aws_ami.ubuntu18.id
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile_api.name

  # set user data for configuring server  
  user_data               = data.template_cloudinit_config.openapi.rendered

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
  vpc_zone_identifier     = module.vpc.public_subnets

  lifecycle {
    create_before_destroy = true
  }
  # tags = var.tags
  tag {
    key                 = "service"
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

resource "aws_autoscaling_policy" "bat" {
  name                   = format("%s-%s-%s-%s-scalepolicy", var.prefix, var.region_name, var.stage, var.service)
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.api_asg.name
}