# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------
terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the  # working directory, into a temporary folder, and execute your Terraform commands in that folder.

  include {
    path = "${find_in_parent_folders()}"
  }

  dependencies {
    paths = ["../Network"]
  }
}

#
# Module Parameter Values
#


internal_source_ranges = ["172.16.0.0/15", "172.17.0.0/22"]

external_source_ranges = ["104.3.119.210/32"]
