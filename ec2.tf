resource "aws_instance" "od-instance" {
  count = var.OD_INSTANCE_COUNT
  instance_type = var.OD_INSTANCE_TYPE
  ami = data.aws_ami.ami.id
}
