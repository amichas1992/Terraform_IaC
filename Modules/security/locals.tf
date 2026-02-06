locals {
  name = "${var.prefix}-sg"
  tags = merge(var.tags, { Name = "${var.prefix}-sg" }
  )
}