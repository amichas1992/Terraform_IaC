variable "prefix" {
  type    = string
  default = "dev"
}

variable "tags" {
  type = map(string)
  default = {
    Project = "TF-IaC"
    Env     = "dev"
  }
}

variable "key_name" {
  type        = string
  description = "EC2 Key pair"
  default     = "demo-key"
}