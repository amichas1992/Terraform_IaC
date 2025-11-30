resource "aws_security_group" "this" {
  name   = local.name
  vpc_id = var.vpc_id
  description = "Security group for ${var.prefix}"

  tags = local.tags
}

# HTTP ingress (0.0.0.0/0)
resource "aws_security_group_rule" "http_in" {
  count       = var.allow_http ? 1 : 0
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
  description = "Allow HTTP from internet"
}

# HTTPS ingress (0.0.0.0/0)
resource "aws_security_group_rule" "https_in" {
  count       = var.allow_https ? 1 : 0
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
  description = "Allow HTTPS from internet"
}

# SSH ingress (restricted)
resource "aws_security_group_rule" "ssh_in" {
  count = length(trimspace(var.allow_ssh)) > 0 ? 1 : 0
  type  = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = [var.allow_ssh]
  security_group_id = aws_security_group.this.id
  description = "Allow SSH from admin CIDR"
}

# Allow all outbound (default). Add egress rules here to restrict.
# AWS default outbound rule applied
