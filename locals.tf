locals {
  ALL_INSTANCE_IDS = concat(aws_instance.od-instance.*.id, aws_spot_instance_request.spot-instance.*.spot_instance_id)
  ALL_SPOT_IDS     = aws_spot_instance_request.spot-instance.*.id
  ALL_TAG_IDS      = concat(local.ALL_SPOT_IDS, local.ALL_INSTANCE_IDS)
  TAG_NAME         = "${var.COMPONENT}-${var.ENV}"

}