
region         = "eu-central-1"
ami_id         = "ami-071878317c449ae48"
instance_type  = "t2.micro"
key_name       = "devKey"
machine_name   = "Emran"
backend-bucket = "dev-terraform-tutorial"
backend-key    = "build/airflow/terraform.tfstate"
vpc_id         = "vpc-0cc7e1e8d0e236d78"
created_by     = "terraform"

tags = {
  description = "A map of tags to assign to the resources"
  Project     = "terraform-tutorial"
  created_by  = "terraform"
}