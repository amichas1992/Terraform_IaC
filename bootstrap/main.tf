provider "aws" {
  region = "eu-central-1"
}

# --- 1. S3 Bucket ---
resource "aws_s3_bucket" "terraform_state" {

  bucket = "terraform-state-portfolio-amichas1992"
  
  # Prevent accidental deletion of the bucket
  lifecycle {
    prevent_destroy = true
  }
}

# Enable Versioning
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable Encryption (Security)
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# --- 2. DynamoDB Table (The "Lock") ---
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST" # Free tier
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# --- Outputs ---
output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
}