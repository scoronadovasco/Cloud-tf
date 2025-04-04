locals {
  sufix = "${var.tags.PROJECT}-${var.tags.Env}-${var.tags.cloud}"
}

resource "random_string" "name_bucket" {
  length = 8
  special = false
  upper = false
}


locals {
  s3-sufix = "${var.tags.PROJECT}-${random_string.name_bucket.id}"
}