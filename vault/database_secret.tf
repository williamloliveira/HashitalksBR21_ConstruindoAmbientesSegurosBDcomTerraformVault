provider "vault" {
  address = var.vault_addr
  token   = var.vault_token
}

resource "vault_mount" "db" {
  path = "mssqldb"
  type = "database"
}

resource "vault_database_secret_backend_connection" "mssql" {
  backend       = vault_mount.db.path
  name          = "mssql"
  allowed_roles = ["dev", "admin"]

  mssql {
    username_template = "{{.DisplayName}}-{{.RoleName | truncate 5}}-{{unix_time}}-{{random 5}}"
    connection_url = format("sqlserver://${var.rds_mssql_user}:${var.rds_mssql_passwd}@${var.rds_mssql_endpoint}:${var.rds_mssql_port}?encrypt=true&TrustServerCertificate=true")
  }
}

resource "vault_database_secret_backend_role" "dev_role" {
  backend             = vault_mount.db.path
  name                = "dev"
  db_name             = vault_database_secret_backend_connection.mssql.name
  
  creation_statements = [
      "USE [master]; CREATE LOGIN [{{name}}] WITH PASSWORD = N'{{password}}'; USE [vault]; CREATE USER [{{name}}] FOR LOGIN [{{name}}]; GRANT SELECT ON SCHEMA::dbo TO [{{name}}];",
  ]       

  revocation_statements = [
      "USE [vault]; DROP USER [{{name}}]; DROP LOGIN [{{name}}];"
  ] 
  
  default_ttl=60
  max_ttl=300
}

resource "vault_database_secret_backend_role" "admin_role" {
  backend             = vault_mount.db.path
  name                = "admin"
  db_name             = vault_database_secret_backend_connection.mssql.name
  
  creation_statements = [
      "USE [master]; CREATE LOGIN [{{name}}] WITH PASSWORD = N'{{password}}'; USE [vault]; CREATE USER [{{name}}] FOR LOGIN [{{name}}]; GRANT SELECT, UPDATE, INSERT, DELETE ON SCHEMA::dbo TO [{{name}}];"
  ]                                             
  
  revocation_statements = [
      "USE [vault]; DROP USER [{{name}}]; DROP LOGIN [{{name}}];"
  ] 
  
  default_ttl=60
  max_ttl=300
}