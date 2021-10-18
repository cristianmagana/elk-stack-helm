module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "devops-sre-vpc"
  cidr = "10.0.0.0/16"

  azs             = [data.aws_availability_zones.available.names[0], 
                     data.aws_availability_zones.available.names[1],
                     data.aws_availability_zones.available.names[2]]
  private_subnets = [cidrsubnet(var.vpc_cidr, 3, 0),
                     cidrsubnet(var.vpc_cidr, 3, 1)]
  public_subnets  = [cidrsubnet(var.vpc_cidr, 3, 5),
                     cidrsubnet(var.vpc_cidr, 3, 6)]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "devops-sre-vpc"
  }
}