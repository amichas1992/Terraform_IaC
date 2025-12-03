module "vpc" {
  source         = "../../modules/vpc"
  prefix         = var.prefix
  tags           = var.tags
  vpc_cidr       = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24"]
}

module "security" {
  source     = "../../modules/security"
  prefix     = var.prefix
  tags       = var.tags
  vpc_id     = module.vpc.vpc_id
  allow_http = true
  allow_ssh  = false
}

module "ec2" {
  source             = "../../modules/ec2"
  instance_type      = "t3.micro"
  prefix             = var.prefix
  tags               = var.tags
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.security.security_group_id]
  key_name           = var.key_name
  userdata           = file("../../modules/ec2/userdata.sh")
}
