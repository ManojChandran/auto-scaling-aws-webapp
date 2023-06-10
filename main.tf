#----root/main.tf-----
terraform {
  # To prevent automatic upgrades to new major versions 
  # that may contain breaking changes
  #--------------------------------------------------------------------------
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  ## Stores the state file back up in s3 bucket
  ## interpolations cannot be used becasue the actvity is done initial stage
  ## need to create s3 bucket and folder prior to using the backend
  #--------------------------------------------------------------------------
  #backend "s3" {
  #  bucket = "myterraformstatebackupfile0002"
  #  key    = "terraform/terraform.tfstate"
  #  region = "us-east-1"
  #}
}

provider "aws" {
  region = "${var.aws-region}"
}

# Deploy VPC and attach IGW
module "vpc_igw" {
  source   = "./modules/10_VPC_igw"
  vpc-cidr = "${var.vpc-cidr}"
}
