# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------
terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "git@github.com:Agilone/agilone_gcp_tf_modules.git//network"
  }

  include {
    path = "${find_in_parent_folders()}"
  }

  dependencies {
    paths = ["../GoogleApiServices"]
  }

}

#
# Module Parameter Values
#

# Reserved Subnets:
# Reserved: 172.31.0.0/16 - It's used in a VPC in AWS.
# Reserved:  172.17.1.0/22 - For OpenVPN connections
# Reserved: 172.16.16.0/20 - ip range used for vpc peering with google managed services.
network_name = "agilone-vpc"

subnets = [
  {
    subnet_name           = "us-west1-red"
    subnet_ip             = "172.16.1.0/24"
    subnet_private_access = "true"
    subnet_flow_logs      = "true"
  },
  {
    subnet_name           = "us-west1-blue"
    subnet_ip             = "172.16.4.0/24"
    subnet_private_access = "true"
    subnet_flow_logs      = "true"
  },
  {
    subnet_name           = "us-west1-green"
    subnet_ip             = "172.16.8.0/24"
    subnet_private_access = "true"
    subnet_flow_logs      = "true"
  },
  {
    subnet_name           = "us-west1-black"
    subnet_ip             = "172.16.12.0/22"
    subnet_private_access = "true"
    subnet_flow_logs      = "true"
  },
  {
    subnet_name           = "us-west1-pink"
    subnet_ip             = "172.16.3.0/24"
    subnet_private_access = "true"
    subnet_flow_logs      = "true"
  },
]

secondary_ranges = {
  us-west1-black = [
    {
      range_name    = "us-west-1-black-secondary-01"
      ip_cidr_range = "192.168.64.0/24"
    },
    {
      range_name    = "us-west-1-black-secondary-02"
      ip_cidr_range = "192.168.96.0/24"
    },
  ]

  us-west1-blue  = []
  us-west1-green = []
  us-west1-red   = []
  us-west1-pink  = []
}

shared_vpc_host = ""
