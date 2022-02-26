data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "base-with-ansible"
  owners      = ["self"]
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-teja"
    key    = "mutable/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}