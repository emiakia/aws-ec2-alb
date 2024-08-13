
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
user_data = <<-EOF
            #!/bin/bash
            yum update -y
            yum install -y httpd
            systemctl start httpd
            systemctl enable httpd
            echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
            EOF




#Application Load balancer Variables 
lb_name                       = "web-lb"
lb_internal                   = false
lb_load_balancer_type         = "application"
lb_enable_deletion_protection = false
lb_tags = {
  "Pupose" = "Test By Terraform For ALB"
}


#Application Load Balancer Target Group
lbtg_name     = "web-tg"
lbtg_port     = 80
lbtg_protocol = "HTTP"
lbtg_tags = {
  "Pupose" = "Test By Terraform For ALB"
}
lbtg_health_check_path     = "/"
lbtg_health_check_protocol = "HTTP"
lbtg_health_check_matcher  = "200"
lbtg_health_check_interval = 30
lbtg_health_check_timeout  = 5
lbtg_healthy_threshold     = 3
lbtg_unhealthy_threshold   = 2

#Load balancer Listener variables
# lblst_load_balancer_arn = 
lblst_port     = 80
lblst_protocol = "HTTP"
#default_action
lblst_default_action_type = "forward"
# lblst_default_action_target_group_arn = 


#Load balancer target group attachment
lbtgatt_port = 80