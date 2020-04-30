data "aws_acm_certificate" "domain" {
  domain    = "abc.com"
}


module "test" {
  source  = "terraform-aws-modules/alb/aws"

  name               = format("%s-%s-%s-%s-alb", var.prefix, var.region_name, var.stage, var.service)
  internal           = false
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  security_groups    = [module.loadbalancer_sg.this_security_group_id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = true

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = data.aws_acm_certificate.domain.arn
      target_group_index = 0
    }
  ]

  target_groups = [
    {
      name_prefix          = "h1"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/healthz"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      tags = {
        InstanceTargetGroupTag = "baz"
      }
    }
  ]

#   access_logs {
#     bucket  = "${aws_s3_bucket.lb_logs.bucket}"
#     prefix  = "test-lb"
#     enabled = true
#   }

  tags = {
    Environment = var.stage
  }
}