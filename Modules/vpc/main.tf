resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = merge(
    local.tags,
    { Name = "${local.name_prefix}-vpc" }
  )
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    local.tags,
    { Name = "${local.name_prefix}-public-${count.index}" }
  )
}
