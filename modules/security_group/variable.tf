variable "name" {
  description = "Name of the security group"
  type        = string
}

# variable "vpc_id" {
#   description = "The VPC ID to create the security group in"
#   type        = string
#   default     = "vpc-0cc7e1e8d0e236d78" 
# }


variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
}