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
    paths = ["../../Core/GoogleApiServices"]
  }
}

#
# Module Parameter Values
#

#
# BigQuery
#
dataset_id = "pdp"
friendly_name = ""
dataset_description = "Powercheck Transactions"
delete_contents_on_destroy = true
dataset_labels = {
  dataset = "pdp"
}

time_partitioning = [
  {
    type = "DAY"
  }
]
view = {}
