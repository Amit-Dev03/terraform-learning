# Custom Terraform Modules Example

This folder demonstrates how to create multiple infrastructure environments by reusing a custom Terraform module.

![Architecture Diagram](Gemini_Generated_Image_gim0lwgim0lwgim0(1).png)

## What this folder does

The root configuration in `main.tf` creates three separate module instances:

- `dev-infra`
- `prod-infra`
- `staging-infra`

Each module call points to the local module directory `./app-infra` and passes environment-specific values such as:

- `env`
- `bucket_name`
- `instance_count`
- `instance_type`
- `ami_id`

## Folder structure

- `main.tf` - Defines the three module blocks for dev, prod, and staging.
- `provider.tf` - Configures the AWS provider for the `ap-south-1` region.
- `terraform.tf` - Declares the required Terraform and AWS provider versions.
- `app-infra/` - Custom module containing the reusable infrastructure resources.

## Module contents

The custom module in `app-infra/` creates:

- an S3 bucket
- an EC2 instance
- a key pair
- a security group
- default VPC-related resources

## Notes

- Bucket names must be globally unique in AWS.
- The EC2 key pair uses a public key file from the local machine, so make sure that file exists before applying.
- This example is intended for learning and demonstration of Terraform module reuse.

## Typical workflow

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Preview the changes:
   ```bash
   terraform plan
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```
