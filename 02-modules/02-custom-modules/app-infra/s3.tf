resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "${var.env}-${var.bucket_name}" # Must be globally unique
  force_destroy = false # Prevents accidental bucket deletion

  tags = {
    Name        =  "${var.env}-${var.bucket_name}" 
    Environment = var.env
  }
}