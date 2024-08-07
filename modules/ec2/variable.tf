variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use"
  type        = string
}

variable "security_groups" {
  description = "List of security group IDs to associate"
  type        = list(string)
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
}

variable "key_name" {
  description = "The key name for SSH access"
  type        = string
}

variable "created_by" {
  description = "Create by Who terraform or Myself"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}