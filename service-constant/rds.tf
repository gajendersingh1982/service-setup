# Get latest snapshot from other account DB
data "aws_db_snapshot" "db_snapshot" {
    most_recent               = true
    db_snapshot_identifier    = var.db_snapshot
    snapshot_type             = "shared"
}

module "db" {
  source                      = "terraform-aws-modules/rds/aws"
  version                     = "~> 2.0"

  name                        = var.db_name
  identifier                  = format("%s-%s-%s-%s-db", var.prefix, var.region_name, var.stage, var.service)

  # Instance Class(t3 or r5)
  instance_class              = var.rds_instance_type

  # DB subnet group
  subnet_ids                  = data.terraform_remote_state.infra.outputs.private_subnets
  vpc_security_group_ids      = [module.db_sg.this_security_group_id]

  # Variables
  # snapshot_identifier       = data.aws_db_snapshot.db_snapshot.id
  multi_az                    = var.multi_az
  publicly_accessible         = var.publicly_accessible

  # Connect Details
  username                    = var.db_username
  password                    = var.db_password
  port                        = "3306"

  #############################################
  # May not be needed for restore from snapshot
  engine                      = "mysql"
  engine_version              = "5.7.19"
  allocated_storage           = var.allocated_storage
  max_allocated_storage       = var.max_allocated_storage
  #############################################

  iam_database_authentication_enabled = false

  # Backup Parameters
  backup_retention_period     = var.backup_retention_period
  maintenance_window          = "Mon:00:00-Mon:03:00"
  backup_window               = "03:00-06:00"

  # # Enhanced Monitoring - see example for details on how to create the role
  # # by yourself, in case you don't want to create it automatically
  # monitoring_interval       = "30"
  # monitoring_role_name      = "MyRDSMonitoringRole"
  # create_monitoring_role      = false

  # DB parameter group
  family                      = "mysql5.7"

  # DB option group
  major_engine_version        = "5.7"

  # Snapshot name upon DB deletion
  final_snapshot_identifier   = format("%s-%s-%s-%s-db-backup", var.prefix, var.region_name, var.stage, var.service)
  copy_tags_to_snapshot       = "true"

  # Database Deletion Protection
  deletion_protection         = true

  parameters = [
    {
      name = "character_set_client"
      value = "utf8"
    },
    {
      name = "character_set_server"
      value = "utf8"
    }
  ]

options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]

  
  tags                        = var.tags
}
