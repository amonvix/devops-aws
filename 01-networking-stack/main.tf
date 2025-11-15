terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket       = "Workshop-nov-remote-backend-bucket"
    key          = "networking/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    #dynamodb_table = "workshop-nov-state-locking-table"     <- modelo antigo ainda usado
  }
}
# Configure the AWS Provider
provider "aws" {
  region = var.assume_role_arn.region
  default_tags {
    tags = var.tags
  }

  assume_role {
    role_arn = var.assume_role_arn.arn
  }

  default_tags {
    tags = var.tags
  }
}
