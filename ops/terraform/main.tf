provider "aws" {
  # version = "~> 2.63"
  region = var.provider_region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_iam_role" "app" {
  name = "${var.name}-${var.env}-app"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com",
          "lambda.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# resource "aws_iam_instance_profile" "app_profile" {
#   name = "${var.name}-${var.env}-app-profile"
#   role = aws_iam_role.app.name
# }


# resource "aws_vpc" "default" {
#   cidr_block = var.cidr_blocks
#   tags = {
#     Name = "${var.name}-${var.env}"
#     env = "${var.env}"
#     Product = "${var.name}"
#   }
# }

# resource "aws_internet_gateway" "default" {
#   vpc_id = aws_vpc.default.id
#   tags = {
#     Name = "${var.name}-${var.env}"
#     env = "${var.env}"
#     Product = "${var.name}"
#   }
# }

# # Grant the VPC internet access on its main route table
# resource "aws_route" "internet_access" {
#   route_table_id         = aws_vpc.default.main_route_table_id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.default.id
# }

# # Create a subnet to launch our instances into
# resource "aws_subnet" "app1" {
#   vpc_id                  = aws_vpc.default.id
#   cidr_block              = "10.0.1.0/24"
#   availability_zone       = "ap-northeast-1c"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "${var.name}-${var.env}"
#     env = "${var.env}"
#     Product = "${var.name}"
#   }
# }

# resource "aws_subnet" "app2" {
#   vpc_id                  = aws_vpc.default.id
#   cidr_block              = "10.0.2.0/24"
#   availability_zone       = "ap-northeast-1a"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "${var.name}-${var.env}"
#     env = "${var.env}"
#     Product = "${var.name}"
#   }
# }

# resource "aws_subnet" "db1" {
#   vpc_id                  = aws_vpc.default.id
#   cidr_block              = "10.0.3.0/24"
#   availability_zone       = "ap-northeast-1c"
#   tags = {
#     Name = "${var.name}-${var.env}"
#     env = "${var.env}"
#     Product = "${var.name}"
#   }
# }

# resource "aws_subnet" "db2" {
#   vpc_id                  = aws_vpc.default.id
#   cidr_block              = "10.0.4.0/24"
#   availability_zone       = "ap-northeast-1a"
#   tags = {
#     Name = "${var.name}-${var.env}"
#     env = "${var.env}"
#     Product = "${var.name}"
#   }
# }

# resource "aws_db_subnet_group" "db" {
#   name        = "RDS subnet"
#   description = "RDS subnet group"
#   subnet_ids  = [aws_subnet.db1.id, aws_subnet.db2.id]
# }


# # Our default security group to access
# # the instances over SSH and HTTP
# resource "aws_security_group" "app" {
#   name        = "scs_v2_api_default"
#   description = "SCS V2 API default"
#   vpc_id      = aws_vpc.default.id

#   # SSH access from anywhere
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # HTTP access from anywhere
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # outbound internet access
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "${var.name}-${var.env}"
#     env = "${var.env}"
#     Product = "${var.name}"
#   }
# }

# resource "aws_security_group" "rds" {
#   name        = "${var.name}-${var.env}_rds_sg"
#   description = "private, inbound only same vpc"
#   vpc_id      = aws_vpc.default.id

#   ingress {
#     from_port   = 0
#     to_port     = 65535
#     protocol    = "TCP"
#     cidr_blocks = [var.cidr_blocks]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags {
#     Name = "${var.name}-${var.env}"
#     env = "${var.env}"
#     role = "app"
#     Product = "${var.name}"
#   }
# }



# resource "aws_db_instance" "default" {
#   depends_on             = [aws_security_group.rds]
#   identifier             = var.db_identifier
#   allocated_storage      = var.db_storage
#   engine                 = "mysql"
#   engine_version         = "8.0.15"
#   instance_class         = "db.t2.micro"
#   username               = var.db_username
#   password               = var.db_password
#   vpc_security_group_ids = [aws_security_group.rds.id]
#   db_subnet_group_name   = aws_db_subnet_group.db.id
#   tags {
#     Name = "${var.name}-${var.env}"
#     env = "${var.env}"
#     Product = "${var.name}"
#   }
# }




# resource "aws_instance" "app" {
#   # The connection block tells our provisioner how to
#   # communicate with the resource (instance)
#   connection {
#     # The default username for our AMI
#     user = "ubuntu"
#     key_file = file(var.key_path)

#     # The connection will use the local SSH agent for authentication.
#   }

#   instance_type = "t2.micro"

#   # Lookup the correct AMI based on the region
#   # we specified
#   ami = var.aws_amis

#   # The name of our SSH keypair we created above.
#   key_name = var.key_name

#   # Our Security group to allow HTTP and SSH access
#   vpc_security_group_ids = [aws_security_group.app.id]

#   # We're going to launch into the same subnet as our ELB. In a production
#   # environment it's more common to have a separate private subnet for
#   # backend instances.
#   subnet_id = aws_subnet.app1.id

#   # IAM Role
#   iam_instance_profile = aws_iam_instance_profile.app_profile.name

#   # EBS
#   root_block_device = {
#     volume_type = "gp2"
#     volume_size = "8"
#   }

#   # We run a remote provisioner on the instance after creating it.
#   # In this case, we just install nginx and start it. By default,
#   # this should be on port 80
#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt-get -y update",
#       "sudo apt-get -y install python-dev",
#     ]
#   }

#   tags = {
#     Name = "${var.name}-${var.env}"
#     Product = "${var.name}"
#     env = "${var.env}"
#     role = "api"
#   }
# }

# resource "aws_eip" "lb" {
#   vpc      = true
#   instance = aws_instance.app.id
# }
