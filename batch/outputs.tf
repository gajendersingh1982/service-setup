output "batch_public_ip" {
  value       = aws_eip.eip_batch.public_ip
  description = "Public IP of Batch Server"
}