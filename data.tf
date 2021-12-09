data "aws_vpc" "vpc_selected" {
    filter {
        name    = "tag:Ambient"
        values  = ["PROD"] 
    }
}

data "aws_subnet_ids" "subnet_selected" {
    vpc_id = data.aws_vpc.vpc_selected.id

    filter {
        name    = "tag:Ambient"
        values  = ["PROD"]
    }
}

data "aws_db_subnet_group" "database_subnet_group" {
    name = var.rds_subnet_group
}

data "aws_kms_alias" "alias" {
    name = "alias/aws/rds"
}