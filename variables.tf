

variable "ami_id" {}

variable "region" { description = "The AWS region to create resources in" }

variable "instance_type" {}
variable "key_name" {}
variable "machine_name" {}
variable "backend-bucket" {}
variable "backend-key" {}
variable "vpc_id" { default = "vpc-0cc7e1e8d0e236d78" }
variable "created_by" {}
variable "tags" {}
