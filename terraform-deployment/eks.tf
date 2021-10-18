module "eks" {
  source          = "terraform-aws-modules/eks/aws"

  cluster_version = "1.18"
  cluster_name    = "devops-sre-cluster"
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.private_subnets


  kubeconfig_aws_authenticator_command         = "aws-iam-authenticator"
  write_kubeconfig                        = "true"
  kubeconfig_output_path                       = "~/.kube/kubeconfig/"
  
  worker_groups = [
    {
      instance_type = "t2.micro"
      asg_max_size  = 3
    }
  ]
}