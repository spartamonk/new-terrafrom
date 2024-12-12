terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.8"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
  default_tags {
    tags = {
      Owner       = "jj-tech-model-batch"
      IaC_Managed = "True"
    }
  }
}