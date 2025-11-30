module "ec2" {
  source = "../../modules/ec2"

  name  = "${var.project_name}-web"
  subnet_id = module.vpc.public_subnet_ids[0]  # first public subnet
  security_group_ids = [module.security.security_group_id]
  key_name = var.ssh_key_name  # optional, set to "" for SSM-only
  userdata = file("${path.module}/../../modules/ec2/userdata.sh")
  # tags = local.common_tags
}

# Use provider settings from global/ (Terraform will merge provider blocks)
# Call VPC
module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr       = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24"]           # single public subnet for free-tier demo
  prefix         = var.project_name
  tags           = { Project = var.project_name, Owner = "Athanasios", Managed = "Terraform" }
}

# Call Security module
module "security" {
  source = "../../modules/security"

  vpc_id      = module.vpc.vpc_id
  prefix      = var.project_name
  tags        = { Project = var.project_name, Owner = "Athanasios", Managed = "Terraform" }

  allow_http  = true
  allow_https = false
  allow_ssh   = var.ssh_allowed_cidr   # empty string disables SSH rule
}

# Create IAM role + instance profile for SSM (so EC2 will register to SSM)
resource "aws_iam_role" "ssm_role" {
  name = "${var.project_name}-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "${var.project_name}-ssm-profile"
  role = aws_iam_role.ssm_role.name
}

# Call EC2 module
module "ec2" {
  source = "../../modules/ec2"

  name               = "${var.project_name}-web"
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.security.security_group_id]
  key_name           = var.ssh_key_name
  userdata           = file("${path.module}/../../modules/ec2/userdata.sh")
  tags               = { Project = var.project_name, Owner = "Athanasios", Managed = "Terraform" }

}


# Attach instance profile for SSM
# iam_instance_profile = aws_iam_instance_profile.ssm_profile.name