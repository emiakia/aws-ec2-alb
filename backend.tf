
terraform {
  backend "s3" {
    bucket = "dev-terraform-tutorial"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
