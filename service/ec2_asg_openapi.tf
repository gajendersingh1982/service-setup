locals {
  asg_ami = data.aws_ami.was_ami.id
}

data "template_file" "openapi_env" {
  template = file("./enviornment.sh")
  vars = {
    aws_access_key_id = var.access
    secret_access_key_id = var.secret
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

  target_group_arns = module.lb_openapi.target_group_arns

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

  
###############
resource "aws_autoscaling_policy" "scalepolicy-scale-out" {
  name                   = format("%s-%s-%s-%s-scale-out-policy", var.prefix, var.region_name, var.stage, var.service)
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.api_asg.name
}

resource "aws_cloudwatch_metric_alarm" "alarm-scale-out" {
  alarm_name          = format("%s-%s-%s-%s-scale-out-alarm", var.prefix, var.region_name, var.stage, var.service)
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.api_asg.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.scalepolicy-scale-out.arn}"]
}

##################
resource "aws_autoscaling_policy" "scalepolicy-scale-in" {
  name                   = format("%s-%s-%s-%s-scale-in-policy", var.prefix, var.region_name, var.stage, var.service)
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.api_asg.name
}

resource "aws_cloudwatch_metric_alarm" "alarm-scale-in" {
  alarm_name          = format("%s-%s-%s-%s-scale-in-alarm", var.prefix, var.region_name, var.stage, var.service)
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "20"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.api_asg.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.scalepolicy-scale-in.arn}"]
}

/*
resource "aws_autoscaling_policy" "scalepolicy2" {
  name                   = format("%s-%s-%s-%s-scalepolicy-2", var.prefix, var.region_name, var.stage, var.service)
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

  target_value = 40.0
  }

  autoscaling_group_name = aws_autoscaling_group.api_asg.name
}
*/

