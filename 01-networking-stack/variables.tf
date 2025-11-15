variable "tags" {
    type    = map(string)
    default = {
        Environment = "production"
        Project     = "workshop-devops-na-nuvem"
    }
}

variable "assume_role" {
    type = object({
        arn     = string
        region  = string
    })
    default = {
      arn = "arn:aws:iam::414813662184:user/cli-amon-devops"
      region = "us-east-1"
    }
}