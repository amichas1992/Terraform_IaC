variable "prefix" {
  description = "The prefix for resource names"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "allow_http" {
  description = "If true, allow HTTP on port 80"
  type        = bool
  default     = false
}

variable "allow_https" {
  description = "If true, allow HTTPS on port 443"
  type        = bool
  default     = false
}

variable "allow_ssh" {
  description = "If true, allow SSH on port 22"
  type        = bool
  default     = false
}

# --- Security Tuning ---
variable "ssh_source_cidr" {
  description = "CIDR block allowed to SSH. Use specific IP for security (e.g. your_ip/32)."
  type        = list(string)
  default     = ["0.0.0.0/0"] # Οpen for now, change to your_ip for ssh lock
  }