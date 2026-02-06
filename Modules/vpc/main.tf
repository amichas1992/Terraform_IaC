resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = merge(
    local.tags,
    { Name = "${local.name_prefix}-vpc" }
  )
}

# --- Internet Gateway (Public Internet Access) ---
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.tags,
    { Name = "${local.name_prefix}-igw" }
  )
}

# --- Public Subnets ---
resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  
  # Optimization: Distribute subnets across Availability Zones for High Availability
  # This picks AZ "a" for index 0, "b" for index 1, etc.
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    local.tags,
    { Name = "${local.name_prefix}-public-subnet-${count.index + 1}" }
  )
}

# --- Routing Table ---
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    local.tags,
    { Name = "${local.name_prefix}-public-rt" }
  )
}

# --- Route Association (Connecting the Subnets to the Map) ---
resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# --- Data Source to fetch AZs dynamically ---
data "aws_availability_zones" "available" {
  state = "available"
}