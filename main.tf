
# Configure the AWS Provider
provider "aws" {
  region = var.region
}



resource "aws_security_group" "scplc_http_ssh" {
  name        = "scplc_http_ssh"
  description = "Allow inbound SSH and HTTP, all outbound"

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound SSH traffic on port 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound HTTP traffic on port 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "scplc_http_ssh"
  }
}

output "security_group_id" {
  value = aws_security_group.scplc_http_ssh.id
}


resource "aws_instance" "sample_http_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  # Attach the security group created above
  vpc_security_group_ids = [aws_security_group.scplc_http_ssh.id]

  tags = {
    Name = "sample_http_server"
  }

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

output "ec2_instance_id" {
  value = aws_instance.sample_http_server.id
}

output "ec2_public_dns" {
  value = aws_instance.sample_http_server.public_dns
}

output "ec2_public_ip" {
  value = aws_instance.sample_http_server.public_ip
}



# resource "aws_instance" "example" {
#   ami           = var.ami_id
#   instance_type = var.instance_type
#   key_name      = var.key_name


#   # User data script
#   user_data = <<-EOF
#     #!/bin/bash
#     # Use this to install your user data (script from top)
#     # install httpd (Linux 2 version)
#     yum update -y httpd
#     service httpd start
#     chkconfig httpd on
#     echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
#   EOF


#   tags = {
#     Name = var.machine_name
#     # Name       = "${var.machine_name} ${count.index}"
#     # Name       = "Emran ${count.index}"
#     created_by = local.created_by
#     owner      = local.owner
#   }
# }





# resource "aws_iam_user" "Emran01" {
#   name = "Emran01"
#   path = "/system/"

#   tags = {
#     created_by = "Terraform"
#   }
# }

# resource "aws_iam_policy" "example_policy" {
#   name        = "example_policy"
#   description = "A policy to grant read-only access to S3"
#   policy      = file("iam_policy.json")

# }
# resource "aws_iam_policy_attachment" "example_user_policy_attachment" {
#   name       = "example_user_policy_attachment"
#   users      = [aws_iam_user.Emran01.name]
#   policy_arn = aws_iam_policy.example_policy.arn
# }

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