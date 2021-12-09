resource "aws_db_parameter_group" "mssql_parameter_group" {
    name    = local.parameter_group_name
    family  = "${local.db_engine}-${local.parameter_group_version}"
    tags    = local.tags
}