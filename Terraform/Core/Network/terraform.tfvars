# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------
terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
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
# Reserved:  172.17.1.0/22 - For OpenVPN connections
# Reserved: 172.16.16.0/20 - ip range used for vpc peering with google managed services.
network_name = "ngm-datalake-vpc"

subnets = [
  {
    subnet_name           = "mgmt-red"
    subnet_ip             = "172.16.1.0/24"
    subnet_private_access = "true"
    subnet_flow_logs      = "true"
  }
]

secondary_ranges = {
  mgmt-red = []
}

shared_vpc_host = ""
