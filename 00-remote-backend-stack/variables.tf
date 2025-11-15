variable "tags" {
  type = map(string)
  default = {
    Environment = "production"
    Project     = "workshop-devops-na-nuvem"
  }
}

variable "assume_role" {
  type = object({
    arn    = string
    region = string
  })
  default = {
    arn    = "arn:aws:iam::414813662184:user/cli-amon-devops"
    region = "us-east-1"
  }
}

variable "remote backend" {
  type = object({
    bucket_name                = string
    dynamo_table_name          = string
    dynamo_table_billing_mode  = string
    dynamo_table_hash_key      = string
    dynamo_table_hash_key_type = string
  })

  default = {
    bucket_name                = "workshop-nov-remote-backend-bucket"
    dynamo_table_name          = "workshop-nov-state-locking-table"
    dynamo_table_billing_mode  = "PAY_PER_REQUEST"
    dynamo_table_hash_key      = "LockID"
    dynamo_table_hash_key_type = "S"
  }
}
