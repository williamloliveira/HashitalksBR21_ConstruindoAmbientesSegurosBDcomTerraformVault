
variable "vault_addr" {
    default = "http://54.221.165.156:8200"
}

variable "vault_token" {
    description = "Token de acesso ao Vault"
}

variable "rds_mssql_endpoint" {
    description = "Endereço de conexão com o SQL Server"
}

variable "rds_mssql_port" {
    description = "Porta de conexão com o SQL Server"
}

variable "rds_mssql_user" {
    description = "Usuario de conexão com o SQL Server"
}

variable "rds_mssql_passwd" {}

variable "rds_mssql_database" {
    description = "Banco de Dados onde o usuario temporario será criado."
}