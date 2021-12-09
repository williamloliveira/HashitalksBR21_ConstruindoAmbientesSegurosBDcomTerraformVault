resource "aws_security_group" "rds_sg" {
    name        = format("%s-rds-sg", var.tag_application)
    vpc_id      = data.aws_vpc.vpc_selected.id
    description = format("Security Group para instancias RDS.")
    tags        = local.tags
}

resource "aws_security_group_rule" "allow4all" {
    type = "ingress"
    from_port = var.db_port
    to_port = var.db_port
    protocol = "tcp"
    security_group_id = aws_security_group.rds_sg.id

    cidr_blocks = ["0.0.0.0/0"]
}