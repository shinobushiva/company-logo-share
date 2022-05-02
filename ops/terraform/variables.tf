variable "access_key" {}
variable "secret_key" {}
variable "aws_region" {
  default = "ap-northeast-1"
}
variable "name" {
  description = "Project Name"
  default = "company-logo-share"
}
variable "env" {
  description = "Environment role on the project"
  default = "development"
}

# variable "aws_amis" {
#   default = "ami-0c1ac8728ef7f87a4"
# }

# variable "key_name" {
#   default = "scs-v2-master"
# }

# variable "key_path" {
#   default = "~/.ssh/scs-v2-master.pem"
# }

# variable "cidr_blocks" {
#   default = "10.0.0.0/16"
# }

# variable "db_identifier" {
#   default = "scs-v2-dev"
# }

# variable "db_storage" {
#   default = "10"
# }

# variable "db_username" {
#   default = "root"
# }

# variable "db_password" {}
