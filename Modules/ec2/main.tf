resource "aws_instance" "main" {
  ami                    = "ami-0a6793a25df710b06" # Amazon Linux 2
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name
  user_data              = var.userdata

  tags = merge(
    var.tags,
    { Name = "${var.prefix}-ec2" }
  )
}