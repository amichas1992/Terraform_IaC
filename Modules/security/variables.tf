variable "vpc_id" {
  description = "VPC id where the security group will be created"
  type        = string
}

variable "prefix" {
  description = "Resource name prefix"
  type        = string
}

variable "tags" {
  description = "Common tags map"
  type        = map(string)
  default     = {}
}

variable "allow_http" {
  description = "Allow HTTP (port 80) from 0.0.0.0/0"
  type        = bool
  default     = true
}

variable "allow_https" {
  description = "Allow HTTPS (port 443) from 0.0.0.0/0"
  type        = bool
  default     = true
}

variable "allow_ssh" {
  description = "Allow SSH (port 22) from specified CIDR. Leave empty to disable."
  type        = string
  default     = ""
}
