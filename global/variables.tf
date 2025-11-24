variable "aws_region" {
  description = "AWS region to use"
  type        = string
  default     = "eu-central-1"
}

variable "aws_profile" {
  description = "AWS CLI profile name"
  type        = string
  default     = "default"
}

variable "project_name" {
  description = "Name prefix for resources"
  type        = string
  default     = "thanos-tf-project"
}
