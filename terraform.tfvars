
# create_sg = false
create_sg      = true
count_instance = 2
# AWS Provider Configuration
region = "eu-central-1"


# Security Group Variables
sg_name        = "SG_HTTP_SSH"
sg_description = "Allow SSH and HTTP inbound traffic"
vpc_id         = "vpc-0cc7e1e8d0e236d78"

ingress_rules = [
  {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
egress_rule = [
  {
    description = "All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
tags = {
  "Pupose" = "Just For Test By Terraform"
  "Name"   = "my-security-group"
}

#aws Instance Variables

ami_id        = "ami-071878317c449ae48"
instance_type = "t2.micro"
key_name      = "devKey"

machine_name = "Emran"
subnets      = ["subnet-093f0311edbfe83fb", "subnet-0a21b416cfd5ab2a3", "subnet-04f0df809d5307602"]
default_sg   = "sg-0a28a74fed00b7df4"

backend-bucket = "dev-terraform-tutorial"
backend-key    = "build/airflow/terraform.tfstate"
created_by     = "Terraform"




#Application Load balancer Variables 
lb_name = "web-lb"
lb_internal = false
lb_load_balancer_type = "application"
lb_enable_deletion_protection = false
lb_tags = {
    "Pupose" = "Just For Test By Terraform"
}
