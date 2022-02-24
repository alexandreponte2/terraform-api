terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

#terraform init -backend=true -backend-config=backend.hcl
#terraform plan -out="tfplan.out"

#aws s3 ls
#terraform init
#terraform init -reconfigure
#terraform init
#terraform show

#The table must have a partition key named LockID with type of String. If not configured, state locking will be disabled.

#dynamodb config
#Table name = tfstate
#Partition key = LockID