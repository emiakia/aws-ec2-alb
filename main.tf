provider "aws" {
  region = "eu-central-1"
}
module "security_group" {
  source = "./modules/security_group"
  # count = 1
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
  count_instance  = var.count_instance
  machine_name    = var.machine_name
  # tags = {
  #   Name = "${var.machine_name} ${count.index}"
  # }
  tags       = var.tags
  created_by = var.created_by

  user_data = var.user_data

}

# Load Balancer and Target Group Configuration
module "alb" {
  source                = "./modules/alb"
  lb_name               = var.lb_name
  lb_internal           = var.lb_internal
  lb_load_balancer_type = var.lb_load_balancer_type
  lb_security_groups    = [module.security_group.id]
  subnets               = var.subnets

  lb_enable_deletion_protection = var.lb_enable_deletion_protection

  lb_tags = var.lb_tags
}


module "lbtg" {
  source        = "./modules/lb_target_group"
  lbtg_name     = var.lbtg_name
  lbtg_port     = var.lbtg_port
  lbtg_protocol = var.lbtg_protocol
  lbtg_vpc_id   = var.vpc_id

  lbtg_health_check_path     = var.lbtg_health_check_path
  lbtg_health_check_protocol = var.lbtg_health_check_protocol
  lbtg_health_check_matcher  = var.lbtg_health_check_matcher
  lbtg_health_check_interval = var.lbtg_health_check_interval
  lbtg_health_check_timeout  = var.lbtg_health_check_timeout
  lbtg_healthy_threshold     = var.lbtg_healthy_threshold
  lbtg_unhealthy_threshold   = var.lbtg_unhealthy_threshold

  lbtg_tags = var.lbtg_tags
}


module "web_listener" {
  source                  = "./modules/lb_listener"
  lblst_load_balancer_arn = module.alb.lb_arn

  lblst_port     = var.lblst_port
  lblst_protocol = var.lblst_protocol

  lblst_default_action_type             = var.lblst_default_action_type
  lblst_default_action_target_group_arn = module.lbtg.tg_arn
}


module "web_tg_attachment" {
  source                   = "./modules/lb_target_group_attachment"
  lbtgatt_count_instance   = module.ec2.instance_ids
  lbtgatt_target_group_arn = module.lbtg.tg_arn
  lbtgatt_target_id        = module.ec2.instance_ids
  lbtgatt_port             = var.lbtgatt_port
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