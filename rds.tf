module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"

  identifier = format("%s-%s-%s-%s-db", var.prefix, var.region_name, var.stage, var.service)

  engine                                = "mysql"
  engine_version                        = "5.7.19"
  instance_class                        = var.rds_instance_type
  allocated_storage                     = 5
  max_allocated_storage                 = 10

  name                                  = "demodb"
  username                              = "user"
  password                              = "YourPwdShouldBeLongAndSecure!"
  port                                  = "3306"

  iam_database_authentication_enabled   = true

  vpc_security_group_ids                = [module.db_sg.this_security_group_id]
  publicly_accessible                   = false

  maintenance_window                    = "Mon:00:00-Mon:03:00"
  backup_window                         = "03:00-06:00"

  # # Enhanced Monitoring - see example for details on how to create the role
  # # by yourself, in case you don't want to create it automatically
  # monitoring_interval                 = "30"
  # monitoring_role_name                = "MyRDSMonitoringRole"
  # create_monitoring_role              = true

  # DB subnet group
  subnet_ids                            = module.vpc.private_subnets

  # DB parameter group
  family                                = "mysql5.7"

  # DB option group
  major_engine_version                  = "5.7"

  # Snapshot name upon DB deletion
  final_snapshot_identifier = format("%s-%s-%s-%s-db-backup", var.prefix, var.region_name, var.stage, var.service)

  # Database Deletion Protection
  deletion_protection     = true

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

  
  tags = var.tags
}