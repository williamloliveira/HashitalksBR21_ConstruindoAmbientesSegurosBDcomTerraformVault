resource "aws_db_instance" "rds_module" {
    allocated_storage                       = var.db_storage_size
    max_allocated_storage                   = local.db_storage_autoscalling
    engine                                  = local.db_engine
    engine_version                          = var.db_engine_version
    instance_class                          = local.db_instance_size
    identifier                              = local.db_instance_name
    username                                = "adminrds"
    password                                = "HASHICORPbr2021"
    parameter_group_name                    = aws_db_parameter_group.mssql_parameter_group.id
    skip_final_snapshot                     = true
    port                                    = var.db_port
    auto_minor_version_upgrade              = true
    backup_retention_period                 = local.db_backup_retention_days
    backup_window                           = var.auto_backup_window
    maintenance_window                      = var.maintenance_window
    copy_tags_to_snapshot                   = true
    delete_automated_backups                = false
    enabled_cloudwatch_logs_exports         = ["agent", "error"]
    kms_key_id                              = data.aws_kms_alias.alias.arn
    storage_encrypted                       = true
    vpc_security_group_ids                  = [aws_security_group.rds_sg.id]
    license_model                           = "license-included"
    db_subnet_group_name                    = var.rds_subnet_group
    performance_insights_enabled            = true
    performance_insights_retention_period   = var.perf_insights_retention_period
    multi_az                                = local.multi_az
    tags                                    = local.tags

}