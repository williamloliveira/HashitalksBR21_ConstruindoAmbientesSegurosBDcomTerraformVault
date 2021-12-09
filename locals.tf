locals {

    db_instance_size        = var.db_instance_size == "" ? lookup(var.db_instance_size, var.environment) : var.db_instance_size[var.environment]
    db_storage_autoscalling = var.environment == "prd" ? (var.db_storage_size * 2) : var.db_storage_size * 1.5
    db_engine               = var.db_engine == "" ? lookup(var.db_engine, var.environment) : var.db_engine[var.environment]
    db_instance_name        = format("%s%s", var.tag_application, var.environment)
    parameter_group_name    = "${local.db_instance_name}pg"
    parameter_group_version = substr(var.db_engine_version, 0, 4)
    db_backup_retention_days= var.environment == "prd" ? 30 : 7
    db_storage_type         = var.environment == "prd" ? "io1" : var.db_storage_type
    db_storage_iops         = local.db_storage_type == "io1" ? var.db_storage_iops : null
    multi_az                = var.environment == "prd" ? true : false

    tags = {
        Name        = local.db_instance_name
        Appliaction = var.tag_application
        Bussiness   = var.tag_business
    }
}