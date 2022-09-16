# Creating a VPC
resource "aws_vpc" "Prod-rock-VPC" {
  cidr_block           = var.cidr-for-vpc
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name = "Prod-rock-VPC"
  }
}


