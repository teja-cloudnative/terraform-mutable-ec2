#
#resource "aws_ec2_tag" "ec2-name-tag" {
#  count       = length(local.ALL_TAG_IDS)
#  resource_id = local.ALL_TAG_IDS[count.index]
#  key         = "Name"
#  value       = local.TAG_NAME
#}

module "tags-ec2" {
  count       = length(local.ALL_TAGS)
  source      = "git::github.com/teja-cloudnative/terraform-tags"
  TAG_NAME    = lookup(element(local.ALL_TAGS, count.index), "name")
  TAG_VALUE   = lookup(element(local.ALL_TAGS, count.index), "value")
  RESOURCE_ID = local.ALL_TAG_IDS
}

locals {
  ALL_TAGS = [
    {
      name   = "name"
      value  = "${var.COMPONENT}-${var.ENV}"
    },
    {
      name   = "name"
      value  = var.ENV
    },
    {
      name   = "component"
      value  = var.COMPONENT
    }
  ]
}