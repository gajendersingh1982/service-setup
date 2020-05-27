output "batch_public_ip" {
  value       = aws_eip.eip_batch.public_ip
  description = "Public IP of Batch Server"
}

output "mail_train_public_ip" {
  value       = aws_eip.eip_mail_train.public_ip
  description = "Public IP of Mail Train Server"
}