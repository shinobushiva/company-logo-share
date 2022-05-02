variable "env" {}

# Network
variable "region" {}
variable "azs" {}
variable "private_subnets" {}
variable "public_subnets" {}

# Compute
variable "api_instance_count" {}
variable "api_instance_type" {}
variable "prd" {}
variable "volume_size" {}

# Data
variable "rds_storage" {}
variable "rds_username" {}
variable "rds_password" {}
variable "rds_instance_type" {}
variable "rds_multi_az" {}
variable "rds_backup_retention_period" {}

# ElastiCache
variable "redis_node_type" {}
variable "redis_private_subnets" {}

provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "sitateru-terraform"
    key    = "scs-v2-api/dev/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "global" {
  backend = "s3"

  config = {
    bucket = "sitateru-terraform"
    key = "scs-v2-api/global/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

# StagingにRDBを貸すため
data "terraform_remote_state" "staging" {
  backend = "s3"

  config = {
    bucket = "sitateru-terraform"
    key = "scs-v2-api/staging/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "feature" {
  backend = "s3"

  config = {
    bucket = "sitateru-terraform"
    key = "scs-v2-api/feature/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

module "network" {
  source = "../../modules/network"

  product = data.terraform_remote_state.global.outputs.product
  env = var.env
  vpc_id = data.terraform_remote_state.global.outputs.vpc_id
  internet_gateway_id = data.terraform_remote_state.global.outputs.internet_gateway_id
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
  azs = var.azs
}

module "compute" {
  source = "../../modules/compute"

  product = data.terraform_remote_state.global.outputs.product
  prd = var.prd
  env = var.env
  vpc_id = data.terraform_remote_state.global.outputs.vpc_id
  api_instance_count = var.api_instance_count
  api_instance_type = var.api_instance_type
  api_subnet_ids = module.network.public_subnet_ids
  key_path = data.terraform_remote_state.global.outputs.key_path
  key_name = data.terraform_remote_state.global.outputs.key_name
  aws_amis = data.terraform_remote_state.global.outputs.aws_amis
  volume_size = var.volume_size
}

resource "aws_security_group_rule" "api_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = module.compute.api_security_group_id
}

resource "aws_security_group_rule" "api_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = module.compute.api_security_group_id
}

resource "aws_eip" "lb" {
  vpc      = true
  instance = element(split(",", module.compute.api_instance_ids), 0)
}

module "data" {
  source = "../../modules/data"

  product = data.terraform_remote_state.global.outputs.product
  env = var.env
  vpc_id = data.terraform_remote_state.global.outputs.vpc_id
  accessable_subnets = concat(var.private_subnets, var.public_subnets, data.terraform_remote_state.staging.outputs.public_subnets, data.terraform_remote_state.feature.outputs.public_subnets)
  rds_subnet_ids = module.network.private_subnet_ids
  rds_storage = var.rds_storage
  rds_password = var.rds_password
  rds_username = var.rds_username
  rds_instance_type = var.rds_instance_type
  rds_multi_az = var.rds_multi_az
  rds_backup_retention_period = var.rds_backup_retention_period
  rds_deletion_protection = false
}

module "redis_private_subnet" {
  source = "../../modules/network/private_subnet"

  product = data.terraform_remote_state.global.outputs.product
  env = var.env
  vpc_id = data.terraform_remote_state.global.outputs.vpc_id
  private_subnets = var.redis_private_subnets
  azs = var.azs
  name-ext = "redis"
}

module "redis" {
  source = "../../modules/data/redis"

  product = data.terraform_remote_state.global.outputs.product
  env = var.env
  vpc_id = data.terraform_remote_state.global.outputs.vpc_id
  subnet_ids = module.redis_private_subnet.subnet_ids
  node_type = var.redis_node_type
}

resource "aws_security_group_rule" "redis_from_ec2" {
  type = "ingress"
  from_port       = 6379
  to_port         = 6379
  protocol        = "tcp"
  security_group_id = module.redis.security_group_id
  cidr_blocks = concat(var.public_subnets, data.terraform_remote_state.staging.outputs.public_subnets, data.terraform_remote_state.feature.outputs.public_subnets)
}
