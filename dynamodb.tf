# 5. Create the DynamoDB Table for State Locking
resource "aws_dynamodb_table" "terraform_locks" {
  name           = "terraform-locks" # Name for your lock table
  billing_mode   = "PAY_PER_REQUEST" # Cost-effective for intermittent usage
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S" # String type for the lock ID
  }
}