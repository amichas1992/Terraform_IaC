variable "prefix" {
  type        = string
  description = "Prefix for naming resources"
}

variable "tags" {
  type        = map(string)
  description = "Common tags for all resources"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  type        = string
  description = "The VPC Subnet ID to launch in"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of Security Group IDs"
}

variable "key_name" {
  type        = string
  default     = "main-key-v2"
  description = "The name of the SSH key pair"
}

variable "userdata" {
  type        = string
  description = "The script to run on boot"
}

variable "iam_instance_profile" {
  type        = string
  description = "IAM Instance Profile to attach to the instance"
  default     = null # Optional, so it doesn't break if you don't pass it
}