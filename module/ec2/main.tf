

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instance_type

  key_name = var.key_name

  tags = {
    Name       = var.instance_name
    created_by = "terraform"
  }
}
