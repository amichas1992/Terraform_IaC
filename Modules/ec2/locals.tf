locals {
  tags = merge(
    var.tags,
    { Name = "${var.prefix}-ec2" }
  )
}