variable "product" {}
variable "env" {}
variable "vpc_id" {}
variable "accessable_subnets" {
  type = "list"
}
variable "rds_storage" {}
variable "rds_username" {}
variable "rds_subnet_ids" {}
variable "rds_password" {}
variable "rds_instance_type" {}
variable "rds_multi_az" {}
variable "rds_backup_retention_period" {}
variable "rds_deletion_protection" {}

module "rds" {
  source = "./rds"

  product = "${var.product}"
  env = "${var.env}"
  vpc_id = "${var.vpc_id}"
  accessable_subnets =  "${var.accessable_subnets}"
  rds_subnet_ids = "${var.rds_subnet_ids}"
  rds_backup_retention_period = "${var.rds_backup_retention_period}"
  db_storage = "${var.rds_storage}"
  db_username = "${var.rds_username}"
  db_password = "${var.rds_password}"
  db_instance_type = "${var.rds_instance_type}"
  multi_az = "${var.rds_multi_az}"
  deletion_protection = var.rds_deletion_protection
}

output "rds_address" { value = "${module.rds.address}" }
