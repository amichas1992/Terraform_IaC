# Find latest Amazon Linux 2 AMI (HVM, x86_64)
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = [var.ami_owner]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  # Associate public IP — ensure subnet map_public_ip_on_launch = true (set in VPC module).
  associate_public_ip_address = true

  # Optionally set SSH key
  key_name = length(trimspace(var.key_name)) > 0 ? var.key_name : null

  # IAM Instance Profile | Ensures the EC2 gets the SSM role via instance profile.
  iam_instance_profile = length(trimspace(var.iam_instance_profile)) > 0 ? var.iam_instance_profile : null

  user_data = var.userdata

  tags = merge(var.tags, { Name = var.name })
}
