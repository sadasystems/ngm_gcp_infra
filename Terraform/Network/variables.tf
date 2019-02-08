variable "project_id" {
  description = "The name of the project"
}

variable "network_name" {
  description = "The name of the network being created"
}

variable "subnets" {
  type        = "list"
  description = "The list of subnets being created"
}

variable "secondary_ranges" {
  type        = "map"
  description = "Secondary ranges that will be used in some of the subnets"
}

variable "shared_vpc_host" {
  type        = "string"
  description = "Makes this project a Shared VPC host if 'true' (default 'false')"
  default     = "false"
}

variable region {
  description = "Region for cloud resources."
  default     = "us-central1"
}
