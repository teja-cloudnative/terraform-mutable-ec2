resource "aws_instance" "od-instance" {
  count = var.OD_INSTANCE_COUNT
  instance_type = var.OD_INSTANCE_TYPE
  ami = data.aws_ami.ami.id
}

resource "aws_spot_instance_request" "spot-instance" {
  count                  = var.SPOT_INSTANCE_COUNT
  ami                    = data.aws_ami.ami.id
  instance_type          = var.SPOT_INSTANCE_TYPE
  wait_for_fulfillment   = true
}

#resource "aws_ec2_tag" "ec2-name-tag" {
#  resource_id = aws_spot_instance_request.spot-instance.spot_instance_id
#  key         = "Name"
#  value       = var.COMPONENT["name"]
#}
#
#resource "aws_ec2_tag" "ec2-monitor-tag" {
#  resource_id = aws_spot_instance_request.od-.spot_instance_id
#  key         = "Monitor"
#  value       = var.COMPONENT["monitor"]
#}