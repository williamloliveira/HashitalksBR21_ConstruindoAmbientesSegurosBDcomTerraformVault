
terraform {
    backend "s3" {
        bucket  = "hctbr"
        key     = "hashicorp/terraform.tfstate"
        encrypt = "true"
        region  = "us-east-1"
    }
}