output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state_bucket.bucket
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
}

output "s3_bucket_region" {
  value = aws_s3_bucket.terraform_state_bucket.region
}

output "ec2_instance_type" {
  value = aws_instance.my_ec2_instance.instance_type
}