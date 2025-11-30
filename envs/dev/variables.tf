variable "project_name" {
  type    = string
  default = "thanos-tf-project"
}

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "ssh_allowed_cidr" {
  description = "Set to 'x.x.x.x/32' to temporarily allow SSH from your IP, or '' to disable."
  type        = string
  default     = ""
}

variable "ssh_key_name" {
  description = "Optional key pair name (for SSH). Leave blank to rely on SSM only."
  type        = string
  default     = ""
}
