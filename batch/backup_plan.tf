resource "aws_backup_plan" "batch" {
  name = format("%s-%s-%s-%s-backup-plan", var.prefix, var.region_name, var.stage, var.service)

  rule {
    rule_name         = "tf_batch_backup_rule"
    target_vault_name = "Default"
    schedule          = "cron(0 12 * * ? *)"
    #start_window       = 480
    #completion_window  = 600
    lifecycle           {
      #cold_storage_after = 14
      delete_after = 365
    }
  }
}

#########################
resource "aws_iam_role" "batch" {
  name               = format("%s-%s-%s-%s-backup-role-001", var.prefix, var.region_name, var.stage, var.service)
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "batch" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.batch.name
}

####################

resource "aws_backup_selection" "batch" {
  iam_role_arn = aws_iam_role.batch.arn
  name         = format("%s-%s-%s-%s-backup-selection", var.prefix, var.region_name, var.stage, var.service)
  plan_id      = aws_backup_plan.batch.id

  resources = [
    module.batch.arn[0]
  ]
}
