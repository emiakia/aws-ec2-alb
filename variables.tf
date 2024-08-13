variable "create_sg" {}

# variable "count_instance" {}


#EC2 Variables
variable "ami_id" {}

variable "region" {}

variable "instance_type" {}
variable "key_name" {}
variable "machine_name" {}
variable "backend-bucket" {}
variable "backend-key" {}
variable "vpc_id" { default = "vpc-0cc7e1e8d0e236d78" }
variable "default_sg" {}
variable "created_by" {}
variable "user_data" {}

variable "tags" {
  type = map(string)
}
variable "count_instance" {
  description = "Number of EC2 instances to create"
  type        = number
}


#Security Group variables
variable "sg_name" {}
variable "sg_description" {}

variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "egress_rule" {
  description = "List of egress rule"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}


variable "subnets" {
  type = list(string)
}

#Application Load balancer Variables 
variable "lb_name" {}
variable "lb_internal" {}
variable "lb_load_balancer_type" {}
variable "lb_enable_deletion_protection" {}
variable "lb_tags" {}


#Application Load Balancer Target Group
variable "lbtg_name" {}
variable "lbtg_port" {}
variable "lbtg_protocol" {}
# variable "lbtg_vpc_id" {}
variable "lbtg_tags" {}
#health_check
variable "lbtg_health_check_path" {}
variable "lbtg_health_check_protocol" {}
variable "lbtg_health_check_matcher" {}
variable "lbtg_health_check_interval" {}
variable "lbtg_health_check_timeout" {}
variable "lbtg_healthy_threshold" {}
variable "lbtg_unhealthy_threshold" {}

#Load balancer Listener variables
# variable "lblst_load_balancer_arn" {}
variable "lblst_port" {}
variable "lblst_protocol" {}
#default_action
variable "lblst_default_action_type" {}
# variable "lblst_default_action_target_group_arn" {}



#Load balancer target group attachment
variable "lbtgatt_port" {}