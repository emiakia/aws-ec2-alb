provider "aws" {
  region = "eu-central-1"
}
module "security_group" {
  source        = "./modules/security_group"
  name          = var.sg_name
  description   = var.sg_description
  vpc_id        = var.vpc_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rule
  tags          = var.tags
}

module "ec2" {
  source          = "./modules/ec2"
  ami             = var.ami_id
  instance_type   = var.instance_type
  security_groups = var.create_sg ? [module.security_group.id] : [var.default_sg]
  key_name        = var.key_name
  count = var.count_instance

  tags = {
    Name = "${var.machine_name} ${count.index}"
  }

  created_by = var.created_by

  user_data  = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
              EOF

}
resource "aws_instance" "web" {
  count         = 2
  ami           = "ami-071878317c449ae48"
  instance_type = "t2.micro"

  user_data  = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "WebServer${count.index + 1}"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow HTTP traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "alb" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = ["subnet-093f0311edbfe83fb", "subnet-0a21b416cfd5ab2a3", "subnet-04f0df809d5307602"] # Replace with your subnet IDs

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0cc7e1e8d0e236d78" # Replace with your VPC ID

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "web" {
  count            = 2
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.web[count.index].id
  port             = 80
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}










###########################################################################
# # Security Group Module
# module "security_group" {
#   source        = "./modules/security_group"
#   name          = var.sg_name
#   description   = var.sg_description
#   vpc_id        = var.vpc_id
#   ingress_rules = var.ingress_rules
#   egress_rules  = var.egress_rule
#   tags          = var.tags
# }

# # EC2 instance Module
# module "ec2" {
#   source          = "./modules/ec2"
#   ami             = var.ami_id
#   instance_type   = var.instance_type
#   security_groups = var.create_sg ? [module.security_group.id] : [var.default_sg]
#   key_name        = var.key_name
#   count = var.count_instance

#   tags = {
#     Name = "${var.machine_name} ${count.index}"
#   }

#   created_by = var.created_by

#   user_data  = <<-EOF
#               #!/bin/bash
#               yum update -y
#               yum install -y httpd
#               systemctl start httpd
#               systemctl enable httpd
#               echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
#               EOF
# }








# output "ec2_instance_id" {
#   value = aws_instance.sample_http_server.id
# }

# output "ec2_public_dns" {
#   value = aws_instance.sample_http_server.public_dns
# }

# output "ec2_public_ip" {
#   value = module.ec2_instance.public_ip
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