variable "name" {
  description = "Instance name prefix"
  type        = string
}

variable "ami_owner" {
  description = "AMI owner for lookup"
  type        = string
  default     = "amazon"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet to launch instance in (public subnet)"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to attach"
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "Optional key pair name. Leave empty to use SSM only."
  type        = string
  default     = "main-key-v2"
}

variable "userdata" {
  description = "User data script"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags map"
  type        = map(string)
  default     = {}
}
