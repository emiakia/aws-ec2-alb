
resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = var.security_groups

  user_data = var.user_data
  tags = var.tags
}
