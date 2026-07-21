terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # Pins the provider version
    }
  }

    backend "s3" {
    bucket         = "amit-pandey-tf-state-bucket-2026" # Must match the one created above
    key            = "project-a/dev/terraform.tfstate" # Unique path for this project
    region         = "ap-south-1"
    use_path_style = true #dynamodb_table = "terraform-locks" old style 
    encrypt        = true
  }
}