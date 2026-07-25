variable "env" {
  description = "The environment for which the resources are being created (e.g., dev, staging, prod)."
  type        = string
  #we cannot set default value here because we're making this custom variable module and we want to pass the value from the root module that is from main.tf. If we set default value here then it will always take that value and we won't be able to pass the value from root module.
}

variable "bucket_name" {
  description = "The name of the S3 bucket to be created."
  type        = string
  #we cannot set default value here because we're making this custom variable module and we want to pass the value from the root module that is from main.tf. If we set default value here then it will always take that value and we won't be able to pass the value from root module.
}

variable "instance_count" {
  description = "The number of EC2 instances to create."
  type        = number
}

variable "instance_type" {
  description = "The type of EC2 instance to create."
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance."
  type        = string
}
