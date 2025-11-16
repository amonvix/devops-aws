terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "workshop-nov-remote-backend-bucket-amon"
    region       = "us-east-1"
    use_lockfile = true
    # dynamodb_table = "workshop-nov-state-locking-table"
  }
}

provider "aws" {
  
  default_tags {
    tags = var.tags
  }
}