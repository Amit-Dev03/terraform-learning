# 1. Create the S3 Bucket
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "amit-pandey-tf-state-bucket-${terraform.workspace}" # Must be globally unique
  force_destroy = false # Prevents accidental bucket deletion
}

# 2. Enable Versioning on the Bucket
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
  
# 3. Enable Server-Side Encryption on the Bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256" # Uses AWS-managed keys
    }
  }
}

# 4. Block Public Access to the Bucket (Security Best Practice)
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}