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

}

#
# Module Parameter Values
#
services_list = [
"oslogin.googleapis.com",
"bigquery-json.googleapis.com",
"containerregistry.googleapis.com",
"file.googleapis.com",
"pubsub.googleapis.com",
"compute.googleapis.com",
"servicenetworking.googleapis.com",
"deploymentmanager.googleapis.com",
"replicapool.googleapis.com",
"replicapoolupdater.googleapis.com",
"resourceviews.googleapis.com", 
"container.googleapis.com", 
"storage-api.googleapis.com",
]