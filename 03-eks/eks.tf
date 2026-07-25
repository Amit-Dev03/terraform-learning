module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = local.eks_cluster_name
  kubernetes_version = "1.33" # If you do not set this, Terraform will use the latest supported version.

  endpoint_public_access = true

  # Grants the current caller admin access to the cluster.
  enable_cluster_creator_admin_permissions = true

  compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Optional: use this only if you have defined intra subnets in the VPC module.
  control_plane_subnet_ids = module.vpc.intra_subnets

  # Define the EKS-managed add-ons.
  addons = {
    coredns = {
      most_recent = true
    }

    kube-proxy = {
      most_recent = true
    }

    vpc-cni = {
      before_compute = true # Install before node groups spin up.
      most_recent    = true
    }

    eks-pod-identity-agent = {
      most_recent = true
    }
  }

  # Define the EKS managed node group for worker nodes.
  eks_managed_node_groups = {
    amit-node-group = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.small"]

      min_size     = 2
      max_size     = 3
      desired_size = 2

      # SPOT is cheaper, but instances can be terminated by AWS at any time.
      capacity_type = "SPOT"

      # Use the cluster's default security group if you do not have a custom one.
      attach_primary_security_group = true
    }
  }

  tags = {
    Environment = local.env
    Terraform   = "true"
  }
}