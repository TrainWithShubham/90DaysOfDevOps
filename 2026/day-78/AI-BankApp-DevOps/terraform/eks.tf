# EKS Cluster — Module v21.x with Kubernetes 1.35
# Uses EKS Pod Identity, access_entries, AL2023 AMI, and AWS provider v6.0+

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  # v21 parameter names (renamed from v20)
  name               = local.name
  kubernetes_version = var.cluster_version

  endpoint_public_access  = true
  endpoint_private_access = true

  # Cluster creator gets admin access via access_entries
  enable_cluster_creator_admin_permissions = true

  # EKS Add-ons (latest versions auto-resolved)
  addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent    = true
      before_compute = true
    }
    eks-pod-identity-agent = {
      most_recent    = true
      before_compute = true
    }
    aws-ebs-csi-driver = {
      most_recent              = true
      service_account_role_arn = module.ebs_csi_irsa.iam_role_arn
    }
    metrics-server = {
      most_recent = true
    }
  }

  # Networking
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  # Managed Node Group
  eks_managed_node_groups = {
    bankapp-ng = {
      instance_types = [var.node_instance_type]
      desired_size   = var.node_desired_count
      min_size       = var.node_desired_count
      max_size       = var.node_max_count

      tags = {
        NodeGroup = "bankapp"
      }
    }
  }

  tags = local.tags
}

# IRSA for EBS CSI Driver (needed to create/attach EBS volumes)
module "ebs_csi_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name             = "${local.name}-ebs-csi"
  attach_ebs_csi_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }

  tags = local.tags
}
