resource "aws_security_group" "main" {
  name        = local.name
  description = "Control access to the EC2 instance"
  vpc_id      = var.vpc_id

  # --- HTTP ---
  dynamic "ingress" {
    for_each = var.allow_http ? [1] : []
    content {
      description = "Allow HTTP from anywhere"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # --- HTTPS ---
  dynamic "ingress" {
    for_each = var.allow_https ? [1] : []
    content {
      description = "Allow HTTPS from anywhere"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # --- SSH (Secured) ---
  dynamic "ingress" {
    for_each = var.allow_ssh ? [1] : []
    content {
      description = "Allow SSH from trusted sources"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.ssh_source_cidr # Check variable for locking!
    }
  }

  # --- Outbound (Allow all) ---
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}