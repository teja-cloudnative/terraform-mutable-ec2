locals {
  ALL_TAGS = [
    {
      name  = "Name"
      value = "${var.COMPONENT}-${var.ENV}"
    },
    {
      name  = "env"
      value = var.ENV
    },
    {
      name  = "component"
      value = var.COMPONENT
    },
    {
      name  = "project_name"
      value = "roboshop"
    }
  ]
}