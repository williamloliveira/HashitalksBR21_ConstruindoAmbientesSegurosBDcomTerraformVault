variable "environment" {
  default = "dev"
  description = "Variavel de ambiente, valores aceitos: dev, hml ou prd"

  validation {
      condition = contains([
          "dev", "hml", "prd"
      ], var.environment)
      error_message = "Argument 'environment' is wrong, please choose a option: dev, hml or prd." 
  }
}

variable "env_full" {
    type = map

    default = {
        dev = "Developer"
        hml = "Quality Assurance"
        prd = "Production"
    }
}

variable "db_engine" {
    description = "Tipo do Banco de Dados a ser criado"
    type        = map

    default = {
        "dev" = "sqlserver-ex"
        "hml" = "sqlserver-se"
        "prd" = "sqlserver-ee"
    } 
}

variable "db_port" {
    description = "Porta de comunicação com o banco de dados"
    default = 6833
}

variable "db_engine_version" {
    description = "Versão da engine de banco de dados"
    default     = "15.00.4073.23.v1" 
}

variable "db_instance_size" {
    type = map
    description = "Tamanho da instancia de banco de dados"

    default = {
        dev = "db.t3.xlarge"
        hml = "db.m5.xlarge"
        prd = "db.r5.xlarge"
    }  
}

variable "db_storage_type" {
    description = "Tipo de storage a ser utilizado pelo RDS. Opções requeridas: gp2 ou io1"
    default     = "gp2"

    validation {
      condition = contains([
          "gp2", "io1"
      ], var.db_storage_type)
      error_message = "Argument 'storage type' is wrong, please choose a option: gp2 ou io1." 
  }
}

variable "db_storage_size" {
    description = "Tamanho do storage do banco de dados RDS."
    default     = 50 
}

variable "db_storage_iops" {
    description = "Quantidade de IOps provisionados, suportado apenas no tipo io1"
    default = 1000
}

variable "auto_backup_window" {
    description = "Janela de execução do backup automatizado de banco de dados."
    default     = "00:00-01:00"
}

variable "maintenance_window" {
    description = "Janela de execução de manutenções no ambiente de banco de dados pela AWS."
    default = "Sun:02:00-Sun:08:00"
}

variable "perf_insights_retention_period" {
    description = "Periodo em que as métricas Performance Insights serão persistidas (Em dias)."
    default     = 7 
}

## ------ Variaveis Mandatórias ------ ##

variable "rds_subnet_group" {
    description = "Subnet Group o qual o banco de dados utilizará para ser provisionado."
}

variable "tag_application" {
    description = "Nome da aplicacao a qual a instancia irá armazenar seus bancos de dados"
}

variable "tag_business" {
    description = "Qual o negocio que esta instancia irá suportar" 
}

