resource "aws_lb" "web_lb" {
  name               = var.lb_name
  internal           = var.lb_internal 
  load_balancer_type = var.lb_load_balancer_type
  security_groups    = var.lb_security_groups
  subnets            = var.subnets

  enable_deletion_protection = var.lb_enable_deletion_protection

  tags = var.lb_tags
}