# VPC for Cluster
data "aws_availability_zones" "azs" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"
  
  name                   = var.name
  cidr                   = var.vpc_cidr_block

  azs                    = data.aws_availability_zones.azs.names
  public_subnets         = var.public_subnet_cidr_blocks
  private_subnets        = var.private_subnet_cidr_blocks

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = var.tags
}

# EKS Cluster
module "eks" {
  source                                   = "terraform-aws-modules/eks/aws"
  version                                  = "~> 20.2"

  cluster_name                             = var.name
  cluster_version                          = var.k8s_version
  cluster_endpoint_public_access           = true

  subnet_ids                               = module.vpc.private_subnets
  vpc_id                                   = module.vpc.vpc_id

  create_cluster_security_group            = false
  create_node_security_group               = false

  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    initial = {
      min_size = 2
      max_size = 4
      desired_size = 2
      instance_types = ["t3.small"]
    }
  }

  tags = var.tags
}

module "ecr" {
  source                      = "terraform-aws-modules/ecr/aws"
  version                     = "~> 2.3.0"

  repository_name             = var.ecr_repo
  registry_scan_type          = "BASIC"
  repository_type             = "private"

  create_lifecycle_policy     = false

  tags = {
    Terraform = true
  }
}
