
# terraform {
#   backend "s3" {
#     bucket = "dev-terraform-tutorial"
#     key    = "terraform.tfstate"
#     # region = var.region
#     region = "eu-central-1"
#   }
# }
# Configure the AWS Provider
provider "aws" {
  region = var.region
}

terraform {

  backend "s3" {
    bucket = "dev-terraform-tutorial"
    key    = "build/airflow/terraform.tfstate"
    region = "eu-central-1"
  }
}

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }

# }
