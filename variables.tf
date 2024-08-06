#variable "ami_id" { default = "ami-071878317c449ae48" }
#variable "instance_type" {default = "t2.micro"}
#variable "key_name" { default = "devKey" }
#variable "machine_name" { default = "Emran" }


variable "ami_id" {
  default     = "ami-071878317c449ae48"
  type        = string
  description = "this is ami id for the machine"
}

variable "region" {
  description = "The AWS region to create resources in"
  default     = "eu-central-1"
}

variable "instance_type" {}
variable "key_name" {}
variable "machine_name" {}
variable "backend-bucket" {}
variable "backend-key" {}


