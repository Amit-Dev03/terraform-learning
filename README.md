# Terraform Learning Repository

This repository is organized so that **each learning topic is an independent Terraform root module**. Every project has its own state file, provider configuration, and lock file while sharing a single remote backend (Amazon S3).

---

# Repository Structure

```text
Terraform/
├── README.md
│
├── 00-backend/
│   ├── provider.tf
│   ├── terraform.tf
│   ├── s3.tf
│   ├── outputs.tf
│   └── terraform.lock.hcl
│
├── 01-tf-basics/
│   ├── provider.tf
│   ├── terraform.tf
│   ├── ec2.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.lock.hcl
│
├── 02-modules/
│   ├── provider.tf
│   ├── terraform.tf
│   ├── variables.tf
│   ├── vpc.tf
│   ├── outputs.tf
│   └── terraform.lock.hcl
│
└── 03-eks/
    ├── provider.tf
    ├── terraform.tf
    ├── variables.tf
    ├── outputs.tf
    └── terraform.lock.hcl
```

---

# Why This Structure?

* Every folder is an **independent Terraform Root Module**.
* Each project has its own:

  * Provider configuration
  * Backend configuration
  * Remote state file
  * Provider lock file (`terraform.lock.hcl`)
* Learning topics are completely isolated from each other.
* Infrastructure created in one project cannot accidentally affect another project.

---

# Backend Project (00-backend)

The `00-backend` project is responsible for creating the **Amazon S3 bucket** that stores Terraform remote state files.

> Since the backend does not exist yet, this project uses the default **local backend**.

Example:

```hcl
terraform {
  required_version = ">= 1.5"
}
```

Do **not** configure an S3 backend inside `00-backend`.

---

# Remote State Configuration

Every Terraform project except `00-backend` uses the same S3 bucket but stores its state in a separate object.

## 01-tf-basics

```hcl
terraform {
  backend "s3" {
    bucket       = "amit-pandey-tf-state-bucket-2026"
    key          = "01-tf-basics/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}
```

---

## 02-modules

```hcl
terraform {
  backend "s3" {
    bucket       = "amit-pandey-tf-state-bucket-2026"
    key          = "02-modules/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}
```

---

## 03-eks

```hcl
terraform {
  backend "s3" {
    bucket       = "amit-pandey-tf-state-bucket-2026"
    key          = "03-eks/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}
```

---

# Remote State Layout

```text
Amazon S3 Bucket
└── amit-pandey-tf-state-bucket-2026
    ├── 01-tf-basics/
    │   └── terraform.tfstate
    │
    ├── 02-modules/
    │   └── terraform.tfstate
    │
    └── 03-eks/
        └── terraform.tfstate
```

Each Terraform project has its own independent state file.

---

# Workflow

## Step 1 - Create the Backend

```bash
cd 00-backend
terraform init
terraform apply
```


This creates the S3 bucket used for remote state.

If you encounter error like: 
```bash
amit@mlops-buddy:/data/Terraform/00-backend$ terraform init
Initializing the backend...

╷
│ Error: Backend configuration changed
│ 
│ A change in the backend configuration has been detected, which may require migrating existing state.
│ 
│ If you wish to attempt automatic migration of the state, use "terraform init -migrate-state".
│ If you wish to store the current configuration with no changes to the state, use "terraform init -reconfigure".

1. first reconfigure -> terraform init -reconfigure
2. then migrate -> terraform init -migrate-state

```

---

## Step 2 - Terraform Basics

```bash
cd ../01-tf-basics
terraform init
terraform plan
terraform apply
```

---

## Step 3 - Terraform Modules

```bash
cd ../02-modules
terraform init
terraform plan
terraform apply
```

---

## Step 4 - Amazon EKS

```bash
cd ../03-eks
terraform init
terraform plan
terraform apply
```

---

# Best Practices

* Keep every Terraform project independent.
* Never share the same state file between multiple projects.
* Store all remote state files in one S3 bucket using different `key` values.
* Commit `terraform.lock.hcl` to Git.
* Do **not** commit:

  * `.terraform/`
  * `*.tfstate`
  * `*.tfstate.*`
  * Sensitive `*.tfvars` files
  * Private keys (`*.pem`, `id_rsa`, etc.)
* Always run Terraform commands from inside the project's directory.
* Keep backend infrastructure (`00-backend`) separate from the infrastructure it manages.

---

# Learning Progress

```text
00-backend
      │
      ▼
01-tf-basics
      │
      ▼
02-modules
      │
      ▼
03-eks
```

Each directory represents a completed learning milestone and can be developed, tested, and destroyed independently without impacting the others.
