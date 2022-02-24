data "aws_ami" "ami" {
  owners = ["self"]
  most_recent = true
  name_regex = "base-with-ansible"
}