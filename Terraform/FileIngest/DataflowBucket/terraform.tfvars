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
name = "ngm-dataflow"

/*
lifecycle_rules = [
    {
      action = [
        {
          type = "Delete"
        },
      ]

      condition = [
        {
          age = 90
        },
      ]
    },
  ]
*/

# append these users to the permissions set.
