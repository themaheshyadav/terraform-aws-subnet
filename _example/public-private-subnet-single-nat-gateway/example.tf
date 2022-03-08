provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source  = "clouddrove/vpc/aws"
  version = "0.15.0"

  name        = "vpc"
  environment = "example"
  label_order = ["name", "environment"]

  cidr_block = "10.0.0.0/16"
}

module "subnets" {
  source = "./../../"

  nat_gateway_enabled = true
  single_nat_gateway  = true
  name                = "subnets"
  environment         = "example"
  label_order         = ["name", "environment"]

  availability_zones              = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  vpc_id                          = module.vpc.vpc_id
  type                            = "public-private"
  igw_id                          = module.vpc.igw_id
  cidr_block                      = module.vpc.vpc_cidr_block
  ipv6_cidr_block                 = module.vpc.ipv6_cidr_block
  assign_ipv6_address_on_creation = false
  egress_private = [
    {
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
    },
    {
      rule_no         = 101
      action          = "allow"
      ipv6_cidr_block = "::/0"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
    }
  ]

  ingress_private = [
    {
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
    },
    {
      rule_no         = 101
      action          = "allow"
      ipv6_cidr_block = "::/0"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
    }
  ]

  egress_public = [
    {
      rule_no    = 100
      action     = "allow"
      cidr_block = "10.0.0.0/16"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
    },
    {
      rule_no         = 101
      action          = "allow"
      ipv6_cidr_block = "::/0"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
    }
  ]

  ingress_public = [
    {
      rule_no    = 100
      action     = "allow"
      cidr_block = "10.0.0.0/16"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
    },
    {
      rule_no         = 101
      action          = "allow"
      ipv6_cidr_block = "::/0"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
    }
  ]

}
