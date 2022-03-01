resource "aws_instance" "od-instance" {
  count         = var.OD_INSTANCE_COUNT
  instance_type = var.OD_INSTANCE_TYPE
  ami           = data.aws_ami.ami.id
  subnet_id     = element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS_ID, count.index)
  vpc_security_group_ids = [aws_security_group.allow.id]
}

resource "aws_spot_instance_request" "spot-instance" {
  count                  = var.SPOT_INSTANCE_COUNT
  ami                    = data.aws_ami.ami.id
  instance_type          = var.SPOT_INSTANCE_TYPE
  wait_for_fulfillment   = true
  subnet_id     = element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS_ID, count.index+1)
  vpc_security_group_ids = [aws_security_group.allow.id]
  //  root_block_device {
  //    volume_size = 10
  //  }
}
