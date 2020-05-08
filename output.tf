output "instance_ip_addr" {
  value = aws_eip.eip_admin.*.public_ip
}