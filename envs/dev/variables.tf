variable "prefix" {
  type        = string
  description = "Project prefix for naming resources"
  default     = "dev"
}

variable "tags" {
  type        = map(string)
  description = "Common resource tags"
}

variable "key_name" {
  type        = string
  description = "Name of the existing AWS Key Pair"
}