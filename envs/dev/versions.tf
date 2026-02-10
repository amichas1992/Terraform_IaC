# --- Without remote s3 state ---
# terraform {
#   required_version = ">= 1.6.0"

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }

# --- Active remote s3 state ---
terraform {
  required_version = ">= 1.6.0"

  # --- Tell Terraform to talk to S3 ---
  backend "s3" {
    bucket         = "terraform-state-portfolio-amichas1992"
    key            = "dev/terraform.tfstate" # Path inside the bucket
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks" # table name
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}