variable "product" {}
variable "env" {}
variable "vpc_id" {}
variable "accessable_subnets" {
  type = "list"
}
variable "rds_subnet_ids" {}
variable "rds_backup_retention_period" {}
variable "db_storage" {}
variable "db_username" {}
variable "db_password" {}
variable "db_instance_type" {}
variable "multi_az" {}
variable "deletion_protection" {}

resource "aws_db_subnet_group" "rds" {
  name        = "${var.product}-${var.env}-rds-sg"
  description = "RDS subnet group"
  subnet_ids  = split(",", var.rds_subnet_ids)
}

resource "aws_security_group" "rds" {
  name        = "${var.product}-${var.env}-rds-sg"
  description = "private, inbound only same vpc"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "TCP"
    cidr_blocks = var.accessable_subnets
  }

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol    = "TCP"
    cidr_blocks = ["192.168.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.product}-${var.env}"
    env = var.env
    role = "app"
    Product = var.product
  }
}


resource "aws_db_parameter_group" "rds-mysql" {
    name = "rds-mysql80-${var.product}-${var.env}"
    family = "mysql8.0"
    description = "scs ars params"

    parameter {
      name  = "character_set_server"
      value = "utf8mb4"
    }

    parameter {
      name  = "character_set_client"
      value = "utf8mb4"
    }
}

resource "aws_db_instance" "default" {
  depends_on             = [aws_security_group.rds]
  identifier             = "${var.product}-${var.env}-my-ssd"
  allocated_storage      = var.db_storage
  max_allocated_storage  = 1000
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.19"
  backup_retention_period = var.rds_backup_retention_period
  backup_window          = "19:00-19:30"
  instance_class         = var.db_instance_type
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.rds.id
  multi_az               = var.multi_az
  parameter_group_name   = aws_db_parameter_group.rds-mysql.name
  deletion_protection    = var.deletion_protection
  skip_final_snapshot = true
  tags = {
    Name = "${var.product}-${var.env}"
    env = "${var.env}"
    Product = "${var.product}"
  }
}

output "address" { value = "${aws_db_instance.default.address}" }
