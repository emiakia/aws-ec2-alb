
# Configure the AWS Provider
provider "aws" {
  region = var.region
}



module "security_group" {
  source = "./modules/security-group"
  sg_name = "allow_ssh_http"
}



# output "security_group_id" {
#   value = aws_security_group.scgrp_http_ssh.id
# }



module "ec2_instance" {
  source = "./modules/ec2"
  instance_type = "t2.micro"
  security_group_id = module.security_group.sg_id
  user_data = <<-EOF
              #!/bin/bash
              # Use this for your user data (script from top to bottom)
              # install httpd (Linux 2 version)
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
              EOF
}


# output "ec2_instance_id" {
#   value = aws_instance.sample_http_server.id
# }

# output "ec2_public_dns" {
#   value = aws_instance.sample_http_server.public_dns
# }

output "ec2_public_ip" {
  value = module.ec2_instance.public_ip
}


# resource "aws_instance" "Emran01" {
#   ami           = var.ami_id
#   instance_type = var.instance_type
#   key_name      = var.key_name
#   count         = 4
#   tags = {
#     Name       = "${var.machine_name} ${var.env_name[count.index]}"
#     # Name       = "${var.machine_name} ${count.index}"
#     # Name       = "Emran ${count.index}"
#     created_by = local.created_by
#     owner = local.owner
#   }
# }

# resource "aws_instance" "Emran02" {
#   ami           = var.ami_id
#   instance_type = var.instance_type
#   key_name      = var.key_name

#   tags = {
#     Name       = var.machine_name
#     created_by = "terraform"
#   }
# }

# terraform import aws_instance.Emran03 i-0aa37f038f15d5d5e
#resource "aws_instance" "Emran3" {
#  ami           = "ami-013efd7d9f40467af"
#  instance_type = "t2.nano"
#  key_name      = var.key_name
#  tags = {
#    Name       = var.machine_name
#  }
#}


# terraform import aws_s3_bucket.bucket dev-terraform-tutorial
# resource "aws_s3_bucket" "bucket" {
#   # (resource arguments)
#   tags = {
#     "created " = "manually"
#   }
# }

/*
# module "ec2_emran1" {
#   source        = "./module/ec2"
#   instance_name = "v011"
#   key_name = "devKey"
# }

# module "ec2_emran2" {
#   source        = "./module/ec2"
#   instance_name = "v012"
#   key_name = "devKey"
# }
*/