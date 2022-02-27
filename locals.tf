locals {
  ALL_OD_INSTANCE_IDS   = concat(aws_instance.od-instance.*.id, aws_spot_instance_request.spot-instance.*.spot_instance_id)
  ALL_SPOT_INSTANCE_IDS = aws_spot_instance_request.spot-instance.*.id
  ALL_TAG_IDS           = concat(local.ALL_OD_INSTANCE_IDS, local.ALL_SPOT_INSTANCE_IDS, local.ALL_VOLUME_IDS)
  TAG_NAME              = "${var.COMPONENT}-${var.ENV}"
  SPOT_VOLUME_ID        = [for m in flatten(aws_spot_instance_request.spot-instance.*.root_block_device) : m.volume_id]
  OD_VOLUME_ID          = [for m in flatten(aws_instance.od-instance.*.root_block_device) : m.volume_id]
  ALL_VOLUME_IDS        = concat(local.SPOT_VOLUME_ID, local.OD_VOLUME_ID)
}

output "ALL_TAGS" {
  value = local.ALL_TAGS
}

output "ALL_TAG_IDS" {
  value = local.ALL_TAG_IDS
}
