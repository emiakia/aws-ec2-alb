
# Configure the AWS Provider
provider "aws" {
  region = var.region
}

resource "aws_iam_user" "Emran01" {
  name = "Emran01"
  path = "/system/"

  tags = {
    created_by = "Terraform"
  }
}

resource "aws_iam_policy" "example_policy" {
  name        = "example_policy"
  description = "A policy to grant read-only access to S3"
  policy      = file("iam_policy.json")

}
resource "aws_iam_policy_attachment" "example_user_policy_attachment" {
  name       = "example_user_policy_attachment"
  users      = [aws_iam_user.Emran01.name]
  policy_arn = aws_iam_policy.example_policy.arn
}

# resource "aws_instance" "Emran01" {
#   ami           = var.ami_id
#   instance_type = var.instance_type
#   key_name      = var.key_name
#   count         = 4
#   tags = {
#     Name       = "${var.machine_name} ${var.env_name[count.index]}"
#     # Name       = "${var.machine_name} ${count.index}"
#     # Name       = "Emran ${count.index}"
#     created_by = local.created_by
#     owner = local.owner
#   }
# }

# resource "aws_instance" "Emran02" {
#   ami           = var.ami_id
#   instance_type = var.instance_type
#   key_name      = var.key_name

#   tags = {
#     Name       = var.machine_name
#     created_by = "terraform"
#   }
# }

# terraform import aws_instance.Emran03 i-0aa37f038f15d5d5e
#resource "aws_instance" "Emran3" {
#  ami           = "ami-013efd7d9f40467af"
#  instance_type = "t2.nano"
#  key_name      = var.key_name
#  tags = {
#    Name       = var.machine_name
#  }
#}


# terraform import aws_s3_bucket.bucket dev-terraform-tutorial
# resource "aws_s3_bucket" "bucket" {
#   # (resource arguments)
#   tags = {
#     "created " = "manually"
#   }
# }

/*
# module "ec2_emran1" {
#   source        = "./module/ec2"
#   instance_name = "v011"
#   key_name = "devKey"
# }

# module "ec2_emran2" {
#   source        = "./module/ec2"
#   instance_name = "v012"
#   key_name = "devKey"
# }
*/