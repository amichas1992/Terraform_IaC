variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of CIDRs for public subnets"
  type        = list(string)
}

variable "prefix" {
  description = "Name prefix for resources"
  type        = string
}

variable "tags" {
  description = "Map of common tags"
  type        = map(string)
}
