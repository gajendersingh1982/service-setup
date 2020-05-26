#output "openapi__http_listner_arns" {
#  description = "List of http listner arns"
#  value       = module.lb_openapi.http_tcp_listener_arns
#}

output "openapi_https_listener_arns" {
  description = "List of https listner arns"
  value       = module.lb_openapi.https_listener_arns
}

output "openapi_target_group_arns" {
  description = "List of target group arns"
  value       = module.lb_openapi.target_group_arns
}

output "openapi_this_lb_arn" {
  description = "LoadBalancer arn"
  value       = module.lb_openapi.this_lb_arn
}

#output "admin__http_listner_arns" {
#  description = "List of http listner arns"
#  value       = module.lb_admin.http_tcp_listener_arns
#}

output "admin_https_listener_arns" {
  description = "List of https listner arns"
  value       = module.lb_admin.https_listener_arns
}

output "admin_target_group_arns" {
  description = "List of target group arns"
  value       = module.lb_admin.target_group_arns
}

output "admin_this_lb_arn" {
  description = "LoadBalancer arn"
  value       = module.lb_admin.this_lb_arn
}

output "admin_alb_sg_id" {
  description = "Security group of Admin LoadBalancer"
  value = module.loadbalancer_admin_sg.this_security_group_id
}

output "openapi_alb_sg_id" {
  description = "Security group of OpenAPI LoadBalancer"
  value = module.loadbalancer_openapi_sg.this_security_group_id
}