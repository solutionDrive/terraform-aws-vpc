# tf_vpc

A terraform Module to create a VPC in an AWS-Account

## Inputs

List of input variables (also check variables.tf)

- `name` name of the VPC  
- `cidr` CIDR of the VPC  
- `public_subnets` A list of public subnets inside the VPC.
- `private_subnets` A list of private subnets inside the VPC.
- `azs` A list of Availability zones in the region
- `enable_dns_hostnames` should be true if you want to use private DNS within the VPC
- `enable_dns_support` should be true if you want to use private DNS within the VPC
- `map_public_ip_on_launch` should be false if you do not want to auto-assign public IP on launch
- `private_propagating_vgws` A list of VGWs the private route table should propagate
- `public_propagating_vgws` A list of VGWs the public route table should propagate.
- `tags` A map of tags to add to all resources.

## Outputs

- `public_subnets` A list with public subnet IDs
- `private_subnets`  A list with private subnet IDs 
- `vpc_id`  ID of the VPC
- `public_route_table_ids` The ID of the public route table
- `private_route_table_ids`  The ID of the private route table
- `default_security_group_id`  The ID of the default security group 
- `igw_id` ID of the internet gateway

## Usage

```
module "vpc" {
  source = "git::ssh://git@github.com/solutionDrive/terraform-aws-vpc.git"
  name = "my_vpc"

  cidr = "10.200.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  public_subnets = ["10.200.101.0/24"]
  private_subnets = ["10.200.100.0/24"]
  azs = ["eu-central-1a"]
  tags = {
    "Terraform" = "true"
    "Environment" = "prod"
  }
}

```