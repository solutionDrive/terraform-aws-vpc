variable "provider_region" {}

variable "profile" {
  description = "the AWS profile to use"
}

variable "assume_role_arn" {
  description = "ARN of the role to use (default = '' | do not use a role to assume)"
  default = ""
}

variable "name" {}

variable "cidr" {}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC."
  type = "list"
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC."
  type = "list"
  default     = []
}

variable "azs" {
  description = "A list of Availability zones in the region"
  type = "list"
  default     = []
}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = false
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = false
}

variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public IP on launch"
  default     = true
}

variable "private_propagating_vgws" {
  description = "A list of VGWs the private route table should propagate."
  type = "list"
  default     = []
}

variable "public_propagating_vgws" {
  description = "A list of VGWs the public route table should propagate."
  type = "list"
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type = "map"
  default     = {}
}
