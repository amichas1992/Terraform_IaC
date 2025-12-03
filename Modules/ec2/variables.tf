variable "prefix" {}
variable "tags" {
  type = map(string)
}
variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "subnet_id" {}
variable "security_group_ids" {
  type = list(string)
}
variable "key_name" {
  type        = string
  default     = "demo-key"
}
variable "userdata" {}
