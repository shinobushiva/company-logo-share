variable "vpc_cidr" {}
variable "product" {}
variable "env" {}
variable "region" {}
variable "key_path" {}
variable "key_name" {}
variable "aws_amis" {}

terraform {
  backend "s3" {
    bucket = "sitateru-terraform"
    key    = "scs-v2-api/global/terraform.tfstate"
    region = "ap-northeast-1"
  }
}


provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../../modules/network/vpc"

  product = var.product
  cidr = var.vpc_cidr
}

module "elasticsearch" {
  source = "../../modules/data/elasticsearch"

  name = var.product
  product = var.product
  env = var.env
}

# VPC
output "vpc_id"   { value = "${module.vpc.vpc_id}" }
output "vpc_cidr" { value = "${module.vpc.vpc_cidr}" }
output "internet_gateway_id" { value = "${module.vpc.internet_gateway_id}" }

# Global Variable
output "product" { value = "${var.product}" }
output "region" { value = "${var.region}" }
output "key_path" { value = "${var.key_path}" }
output "key_name" { value = "${var.key_name}" }
output "aws_amis" { value = "${var.aws_amis}" }
