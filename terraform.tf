terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # Pins the provider version
    }
  }

    backend "s3" {
    bucket         = "amit-pandey-tf-state-bucket-${terraform.workspace}" # Must match the one created above
    key            = "project-a/dev/terraform.tfstate" # Unique path for this project
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}