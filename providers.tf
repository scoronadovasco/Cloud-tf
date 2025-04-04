terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.acces_key
  secret_key = var.secret_key
  default_tags {
    tags = var.tags
  }
}


