variable "prefix" {}
variable "tags" {
  type = map(string)
}
variable "vpc_id" {}
variable "allow_http" {}
variable "allow_ssh" {}
