locals {
  common_tags = {
    Project = var.project_name
    Owner   = "Thanos_M"
    Managed = "Terraform"
  }

  resource_prefix = lower(replace(var.project_name, " ", "-"))
}
