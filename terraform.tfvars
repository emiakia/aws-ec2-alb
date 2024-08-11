region = "eu-central-1"

ami_id         = "ami-071878317c449ae48"
instance_type  = "t2.micro"
key_name       = "devKey"
machine_name   = "Emran"
sg_name        = "SG_HTTP_SSH"
backend-bucket = "dev-terraform-tutorial"
backend-key    = "build/airflow/terraform.tfstate"
created_by     = "Terraform"
tags = {
  "Pupose" = "Just For Test By Terraform"
  "Name"   = "my-security-group"
}

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