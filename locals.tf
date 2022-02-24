locals {
  ALL_INSTANCE_IDS = concat(aws_instance.od-instance.*.id, aws_spot_instance_request.spot-instance.*.spot_instance_id)
  TAG_NAME         = "${var.COMPONENT}-${var.ENV}"
}