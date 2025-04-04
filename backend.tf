# terraform {
#   required_version = ">= 1.0.0"

#   backend "s3" {
#     region  = "us-east-1"
#     bucket  = "crocs-prd-terraform-state"
#     key     = "terraform.tfstate"
#     profile = ""
#     encrypt = "true"

#     dynamodb_table = "crocs-prd-terraform-state-lock"
#   }
# }
